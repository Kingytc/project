<%@include file="../share/directives.jsp"%>
<%
String strCons_Owner=Helper.correctNull((String)hshValues.get("comapp_ownership"));
String flag=Helper.correctNull((String)hshValues.get("flag"));
String comments=Helper.correctNull((String)hshValues.get("comments"));
String strbankarrangement=Helper.correctNull((String)hshValues.get("bankarrangement"));

HashMap hshAppdata=new HashMap();
hshAppdata=(HashMap)hshValues.get("hshAppdata");

String strAppno="";
String strcbsid="";
String appname="";
String strAppstatus="";
String appstatus="";
String strAppname="";
String readFlag="";
String strBorrowertype="";
String strmoduletype="";
String strBTNEnable="";
String npaorgscode="";
String strAppholder="";
String strOrgname="";

strAppno = Helper.correctNull((String) hshAppdata.get("npaappno"));
strcbsid = Helper.correctNull((String) hshAppdata.get("cbsid"));
appname = Helper.correctNull((String) hshAppdata.get("customername"));
strAppname=Helper.encodeAmpersand(appname);
appstatus = Helper.correctNull((String) hshAppdata.get("status"));
strBorrowertype = Helper.correctNull((String) hshAppdata.get("demoapptype"));
strmoduletype = Helper.correctNull((String) hshAppdata.get("moduletype"));
strBTNEnable = Helper.correctNull((String) hshAppdata.get("btnenable"));
readFlag= Helper.correctNull((String) hshAppdata.get("readflag"));
npaorgscode=Helper.correctNull((String) hshAppdata.get("createorgscode"));
strAppholder=Helper.correctNull((String) hshAppdata.get("holduserid"));
strOrgname=Helper.correctNull((String) hshAppdata.get("apporgname"));

if(appstatus.equalsIgnoreCase("OP")||appstatus.equalsIgnoreCase("PP")){
	strAppstatus="Open/Pending";
}
else if(appstatus.equalsIgnoreCase("PA")){
	strAppstatus="Processed/Approved";
}
else if(appstatus.equalsIgnoreCase("PR")){
	strAppstatus="Processed/Rejected";
}
else if(appstatus.equalsIgnoreCase("CA")){
	strAppstatus="Closed/Approved";
}
else if(appstatus.equalsIgnoreCase("CR")){
	strAppstatus="Closed/Rejected";
}%>
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
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var selfield="<%=Helper.correctNull((String)hshValues.get("propfor"))%>";
var sanctionAuthority="<%=Helper.correctNull((String)hshValues.get("sancauth"))%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var varbankarrangement="<%=strbankarrangement%>";
var filselenforce="<%=Helper.correctNull((String)hshValues.get("fil_sel_enforce"))%>";
var regpremises="<%=Helper.correctNull((String)hshValues.get("regoffpremises"))%>";
var facpremises="<%=Helper.correctNull((String)hshValues.get("facpremises"))%>";

var flag="<%=flag%>";
var comments="<%=comments%>";
var varOrgLevel="<%=strOrgLevel%>";  

function disableCommandButtons(valedit,valapply,valcancel,valclose)
{
	document.forms[0].cmdedit.disabled=valedit;
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;		 
	document.forms[0].cmdclose.disabled=valclose;
}
function doDelete()
{
	if(ConfirmMsg(101))
	{	
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidSourceUrl.value="/action/34PointsFormat_page1.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanMethod.value="updateGeneralinfoData";
		document.forms[0].hidBeanGetMethod.value="getGeneralinfoData";
		document.forms[0].action=appURL +"controllerservlet";
		document.forms[0].submit(); 
	}
}

function onLoading()
{
	if(comments!="")
	{
		alert(comments);
		document.forms[0].action=appURL+"action/npa_mainlinknav.jsp";
		document.forms[0].submit();
	}	
	
	if(document.forms[0].appno.value=="NEW")
	{
		disableFields(false);
		document.forms[0].hidAction.value ="insert";
		document.forms[0].hideditflag.value="Y";
		document.forms[0].selproptype.focus();
		disableCommandButtons(true,false,true,false);	
	}
	else
	{
		if(selfield!="")
		{
		  document.forms[0].selproptype.value=selfield;
		}
		else
		{
			document.forms[0].selproptype.value="1";	
		}
		
		if(sanctionAuthority!="")
		{
		  document.forms[0].txt_sancauth.value=sanctionAuthority;
		}
		else
		{
			document.forms[0].txt_sancauth.value="0";	
		}
		if(filselenforce!="")
		{
		  document.forms[0].sel_enforce.value=filselenforce;
		}
		else
		{
			document.forms[0].sel_enforce.value="y";	
		}
		if(regpremises!="")
		{
			document.forms[0].sel_regoffpremises.value=regpremises;
		}
		else
		{
			document.forms[0].sel_regoffpremises.value="0";
		}
		if(facpremises!="")
		{
			document.forms[0].sel_facpremises.value=facpremises;
		}
		else
		{
			document.forms[0].sel_facpremises.value="0";
		}	
		if(varbankarrangement!="")
		{
			document.forms[0].sel_bankarrangement.value=varbankarrangement;	
		}
		else
		{
			document.forms[0].sel_bankarrangement.value="0";
		}	
		disableFields(true);
		//disableCommandButtons(false,true,true,false);
	}
	document.all.cmddelete.style.visibility="hidden";
	document.all.cmddelete.style.position="absolute";
}

function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hideditflag.value="Y";
	disableCommandButtons(true,false,false,true);	
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanGetMethod.value="getGeneralinfoData";
		document.forms[0].action=appURL +"action/34PointsFormat_page1.jsp";
		document.forms[0].submit(); 		
	}	
}

function doSave()
{
	if(document.forms[0].txt_bankarrangement.value=="")
	{
		alert("Enter Banking Arrangement");
		document.forms[0].txt_bankarrangement.focus();
		return;
	}
	if(document.forms[0].txt_lastreview.value=="")
	{
		alert("Enter the Last Review Date");
		document.forms[0].txt_lastreview.focus();
		return;
	}
	document.forms[0].txt_sancauth.disabled = false;
	document.forms[0].hidSancAuth.value = document.forms[0].txt_sancauth[document.forms[0].txt_sancauth.selectedIndex].text;
	document.forms[0].txt_sancauth.disabled = true;
	document.forms[0].hidBeanId.value="npacommon";
	document.forms[0].hidBeanGetMethod.value="updateGeneralinfoData";
	document.forms[0].action=appURL+"action/34PointsFormat_page1.jsp";
	document.forms[0].submit();
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	  
		if(document.forms[0].elements[i].type=='select-one' )
		  {
 				document.forms[0].elements[i].disabled=val;
		  }
		 if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}  
	}
	document.forms[0].txt_do_ieb.readOnly=true;
	document.forms[0].txt_advancesince.readOnly=true;
	document.forms[0].txt_sanctioned_date.readOnly=true;
	document.forms[0].txt_disbdate.readOnly=true;  
	document.forms[0].txt_Nature_Business.readOnly=true; 
	document.forms[0].txt_Sectoral_cat.readOnly=true;
	document.forms[0].txt_npasince.readOnly=true;
	document.forms[0].txt_sancauth.disabled=true;	
}
function doClose()
{
	if(ConfirmMsg('100'))
	{
		document.forms[0].method="post";	
		document.forms[0].action=appURL+"action/"+"npa_mainlinknav.jsp";
		document.forms[0].submit();
	}
}

function callLink(page,bean,method)
{
	if (document.forms[0].hideditflag.value=="N")
	{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit();
	}
}

function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);
	}
}

function callRegistered()
{
        var npa_appno=document.forms[0].npa_appno.value;
        var hidmoduletype="STAT";
		var selPrint="Get";
		
		var CompanyName=document.forms[0].borrowername.value;
		var purl ="<%=ApplicationParams.getAppUrl()%>action/filingofsuit_registered.jsp?hidBeanGetMethod=getFilingregistered&hidBeanId=npa&npa_appno="+npa_appno+"&borrowername="+CompanyName+"&hidmoduletype="+hidmoduletype+"&comapp_id="+document.forms[0].cbsid.value+"&selPrint="+selPrint;;
	var title = "RegisteredDetails";
	var prop = "scrollbars=yes,width=900,height=550,menubar=yes";
	prop = prop + ",left=50,top=150";
    window.open(purl,title,prop);		
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
<form name="34pointsFormatpage1" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			align="left" class="outertable">
			<tr>
				<td><lapstab:suiturltag pageid="1" /></td>
			</tr>
			<tr>
				<td valign="top" class="page_flow">Home -&gt; NPA-&gt; Filing Of
				Suit -&gt; General -&gt; Banking Details</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
	<tr class='applicationheader'>
		<td nowrap><b>Application No :</b></td>
		<td nowrap><b><%=strAppno%></b></td>

		<td nowrap><b>Applicant Name:</b></td>
		<td nowrap><b><%=appname%></b></td>
		
		<td nowrap><b>CBS CUSTOMER ID:</b></td>
		<td nowrap><b><%=strcbsid%></b></td>

		<td nowrap><b>Status:</b></td>
		<td nowrap><b><%=strAppstatus%></b></td>
	</tr>
	<tr class='applicationheader'>
		<td nowrap><b>Application Holder:</b></td>
		<td nowrap><b><%=strAppholder%></b></td>

		<td nowrap><b>Application Recd. from:</b></td>
		<td nowrap><b><%=strOrgname%></b></td>
		
		<td colspan="4">&nbsp;
		<input type="hidden" name="appstatus" value="<%=appstatus%>">
		<input type="hidden" name="appname" value="<%=strAppname%>">
		<input type="hidden" name="cbsid" value="<%=strcbsid%>">
		<input type="hidden" name="npaorgcode" value="<%=npaorgscode%>">
		<input type="hidden" name="appno" value="<%=strAppno%>">
		<input type="hidden" name="readFlag" value="<%=readFlag%>">
		<input type="hidden" name="hidmoduletype" value="<%=strmoduletype%>">
		<input type="hidden" name="hidborrowertype" value="<%=strBorrowertype%>">
		<input type="hidden" name="btnenable" value="<%=strBTNEnable%>">
		<input type="hidden" name="appholder" value="<%=strAppholder%>">
		<input type="hidden" name="apporgname" value="<%=strOrgname%>">
		</td>		
	</tr>
</table>
<lapstab:npabankingdetails module='<%=strmoduletype%>' pageid="5" bankarrangement='<%=strbankarrangement%>' /><br>
<table width="100%" border="1" cellpadding="0" cellspacing="0" class="outertable">
<tr>
	<td valign="top">
	<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
		<tr>
			<td>
			  <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">               
                <tr valign="top"> 
                  <td>Suit to be filed at</td>
                  <td> 
                    <SELECT NAME="selproptype" TABINDEX="1">
                      <OPTION VALUE="1">----Select----</OPTION>
                      <OPTION VALUE="2">DRT</OPTION>
                      <OPTION VALUE="3">CIVIL COURT</OPTION>
                      <OPTION VALUE="4">RRA</OPTION>
                      <OPTION VALUE="5">LOK ADALAT</OPTION>
                      <OPTION VALUE="6">OTHERS</OPTION>
                    </SELECT>
                  </td>
                  <td width="24%">Sectoral category</td>
                  <td width="25%"> 
                    <input type="text" name="txt_Sectoral_cat"
						tabindex="2" size="35" maxlength="25"
						value="<%=Helper.correctNull((String)hshValues.get("sector"))%>"
						>
                  </td>
                </tr>
                <tr valign="top"> 
                  <td>Constitution</td>
                  <td> 
                    <input type="text"
						name="sel_constitution"
						value="<%=Helper.correctNull((String)hshValues.get("constitution"))%>"
						>
                  </td>
                  <td width="24%">Banking Arrangement <span class="mantatory">*&nbsp;</span></td>
                  <td width="25%"> 
                    <input type="hidden" name="sel_bankarrangement" value="<%=Helper.correctNull((String)hshValues.get("bankarrangement"))%>">
						<input type="text" name="txt_bankarrangement" 
						value="<%=Helper.correctNull((String)hshValues.get("bankarrangement")).equals("1")?"Sole":Helper.correctNull((String)hshValues.get("bankarrangement")).equals("2")?"Consortium":Helper.correctNull((String)hshValues.get("bankarrangement")).equals("3")?"Multiple":"" %>" />
						</td>
                </tr>
                <tr valign="top"> 
                  <td>Registered Office Address :</td>
                  <td> 
                    <textarea name="txt_regoffaddr" cols="50" rows="5" onKeyPress="textlimit(this,1999)" onKeyUp="textlimit(this,1999)"
						><%=Helper.correctNull((String)hshValues.get("regoffaddr"))%></textarea>
                  </td>
                  <td>Office premises</td>
                  <td> 
                    <select name="sel_regoffpremises">
                      <option value="0" selected>&lt;---Select---&gt;</option>
                      <option value="1">Rented</option>
                      <option value="2">Owned</option>
                      <option value="3">Leased</option>
                    </select>
                  </td>
                </tr>
                <tr valign="top"> 
                  <td>Factory Address :</td>
                  <td> 
                    <textarea name="txt_facaddr" cols="50" rows="5" onKeyPress="textlimit(this,1999)" onKeyUp="textlimit(this,1999)" ><%=Helper.correctNull((String)hshValues.get("facoffaddr"))%></textarea>
                  </td>
                  <td>Factory premises</td>
                  <td> 
                    <select name="sel_facpremises">
                      <option value="0" selected>&lt;---Select---&gt;</option>
                      <option value="1">Rented</option>
                      <option value="2">Owned</option>
                      <option value="3">Leased</option>
                    </select>
                  </td>
                </tr>
                <tr valign="top"> 
                  <td>Nature of Business</td>
                  <td> 
                    <input type="text" name="txt_Nature_Business"
						size="35" maxlength="25"
						value="<%=Helper.correctNull((String)hshValues.get("activity"))%>"
						>
                  </td>
                  <td width="24%">Date of Establishment / incorporation.</td>
                  <td width="25%"> 
                    <input type="text" name="txt_do_ieb" size="15"
						maxlength="25" tabindex="3"
						value="<%=Helper.correctNull((String)hshValues.get("do_ieb"))%>"
						onBlur="checkDate(this);checkmaxdate(this,currentDate)">
                    <a
						href="#" onClick="callCalender('txt_do_ieb')"
						title="Click to view calender" border=0><img
						src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
						border="0" tabindex="3"></a></td>
                </tr>
                <tr valign="top"> 
                  <td>Date account opened.</td>
                  <td> 
                    <input type="text" name="txt_advancesince"
						size="15" maxlength="25"
						value="<%=Helper.correctNull((String)hshValues.get("advancesince"))%>">                 
                  </td>
                  <td width="24%">NPA Since</td>
                  <td width="25%"> 
                    <input type="text" name="txt_npasince" maxlength="10"
									value="<%=Helper.correctNull((String)hshValues.get("npasince"))%>"
									size="12" 
									onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>')">
								</td>
                </tr>
                <tr valign="top"> 
                  <td>Last Review date <span class="mantatory">*&nbsp;</span></td>
                  <td> 
                    <input type="text" name="txt_lastreview" size="15"
						maxlength="25" tabindex="3"
						value="<%=Helper.correctNull((String)hshValues.get("lastrevdate"))%>"
						onBlur="checkDate(this);" >
                  </td>
                  <td width="24%">Provision Amount</td>
                  <td width="25%">&nbsp;<input type="text" name="txt_provision"
							maxlength="15" tabindex="2"  
							value='<%=Helper.correctNull((String)hshValues.get("provision"))%>'
							size="20" /></td>
                </tr>
                <tr valign="top"> 
                  <td colspan="4">Date of sanction of credit facilities and sanctioning 
                    Authority</td>
                </tr>
                <tr valign="top"> 
                  <td>Originally sanctioned date</td>
                  <td> 
                    <input type="text" name="txt_sanctioned_date"
						size="15" maxlength="25"
						value="<%=Helper.correctNull((String)hshValues.get("DATE_SACTIONED"))%>"
						>
                  </td>
                  <td width="24%">Disbursed date</td>
                  <td width="25%"> 
                    <input type="text" name="txt_disbdate" size="15"
						maxlength="25"
						value="<%=Helper.correctNull((String)hshValues.get("disbdate"))%>">
                  </td>
                </tr>
                <tr valign="top"> 
                  <td>Sanctioning Authority(ies)</td>
                  <td> 
                    <select name="txt_sancauth"
						tabindex="4">
                      <option value="0" selected>-----select-----</option>
                     <% String apptype="21"; %>
            <lapschoice:StaticDataNewTag apptype='<%=apptype%>'/> 
                    </select>
                    <input type="hidden" name="sel_sancauth" 
						value="<%=Helper.correctNull((String)hshValues.get("sancauth"))%>">                    
                  </td>
                  <td width="24%">&nbsp;</td>
                  <td width="25%">&nbsp;</td>
                </tr>
                <tr valign="top"> 
                  <td colspan="2">Whether credit facility (ies) were subsequently 
                    renewed and / or enhanced. If so, <br>
                    give detailed particulars thereof as follows: -</td>
                  <td width="24%"> 
                    <select name="sel_enforce" onChange=""
						tabindex="5">
                      <option value="y">Yes</option>
                      <option value="n">No</option>
                    </select>
                  </td>
                  <td width="25%">&nbsp;</td>
                </tr>
                <tr valign="top"> 
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td width="24%">&nbsp;</td>
                  <td width="25%">&nbsp;</td>
                </tr>
              </table>
			</td>
		</tr>
		<%if (Helper.correctNull((String)hshValues.get("constitution")).equalsIgnoreCase("006")||Helper.correctNull((String)hshValues.get("constitution")).equalsIgnoreCase("007"))
					{%>
		<tr>
			<td><INPUT TYPE="button" NAME="cmd_reldet" VALUE="Registered Details"
				STYLE="width:250" CLASS="buttoncolor" ONCLICK="callRegistered()"></td>
			<td>&nbsp;</td>
		</tr>
		<%}%>
	</table>
</td>
</tr>
</table>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=strBTNEnable%>' /> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidCostitution" value="<%=strCons_Owner%>" /> 
<input type="hidden" name="hidtype"> 
<input type="hidden" name="hidbankarrangement" value="<%=strbankarrangement%>">
<input type="hidden" name="hidSancAuth">
<input type="hidden" name="hidDataFlag" value="<%=Helper.correctNull((String)hshValues.get("recordFlag"))%>">
</form>
</body>
</html>
