<%@include file="../share/directives.jsp"%>
<%String strSector=Helper.correctNull((String)request.getParameter("hidsector"));
String strSaral = Helper.correctNull((String) request.getParameter("hidsaral"));
String strstatus = Helper.correctNull((String) request.getParameter("hidstatus"));
String strAppAtached= Helper.correctNull(request.getParameter("hidappatached"));
String strapplevel = Helper.correctNull((String)request.getParameter("applevel"));
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Duediligence Report</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var recflag="<%=Helper.correctNull((String)hshValues.get("recordflag"))%>";
var selService="<%=Helper.correctNull((String)hshValues.get("strService"))%>";
var appstatus="<%=Helper.correctNull(request.getParameter("appstatus"))%>";
var varsaral="<%=strSaral%>";
var varOrgLevel="<%=strOrgLevel%>";	
var varright= "<%=Helper.correctNull((String) session.getAttribute("strGroupRights")).charAt(18)%>";

function disableCommandButtons(cmdedit,cmdsave,cmdcancel,cmddelete,cmdclose)
{
 	document.forms[0].cmdedit.disabled=cmdedit;
	document.forms[0].cmdsave.disabled=cmdsave;
	document.forms[0].cmdcancel.disabled=cmdcancel;
	document.forms[0].cmddelete.disabled=cmddelete;
	document.forms[0].cmdclose.disabled=cmdclose;
}

function onLoading()
{
	if(selService!="s")
	{
		document.forms[0].selService.value=selService;
	}
	if(selService=="")
	{
		document.forms[0].selService.value='s';
	}
	if(recflag=='Y')
	{
		document.all.flag.style.visibility="visible";
	}
	else
	{
		document.all.flag.style.visibility="hidden";
	}
	
	//If access through the Loan Application Register and its at Branch 
	if("<%=strSaral%>"=="saral" && "<%=strOrgLevel%>"=="A"){ 
		//If the Application is in open status
	    if("<%=strstatus%>"=="O" && varright=="w"){
		    enableButtons(false,true,true,true,false);
		}else{
			enableButtons(true,true,true,true,false);	
		}
			
	}else if("<%=strSaral%>"=="saral" && "<%=strapplevel%>" == ""){ 
		
		enableButtons(true,true,true,true,false);	
		
    }else{
		
		//Access through Branch Users
		if("<%=strapplevel%>" == "S"){
			enableButtons(true,true,true,true,false);
		}
	}


	disableFields(true);
}

function enableButtons(valedit,valapply,valcancel,valdel,valclose)
{
	document.forms[0].cmdedit.disabled=valedit;	  	
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdclose.disabled=valclose;
}

function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="U";
	disableCommandButtons(true,false,false,false,true);	
	disableFields(false);
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="lapsReport";		
		document.forms[0].hidBeanGetMethod.value="getDueDiligenceRetail";
		document.forms[0].action=appURL+"action/Duediligence1.jsp";	
		document.forms[0].submit();
	}		
	if(appstatus=="Processed/Rejected" || appstatus=="Processed/Approved" || appstatus=="Closed/Approved" ||appstatus=="Closed/Rejected")
	{
		disableFields(true);
		disableCommandButtons(true,true,true,true,false);
	}	
	else
	{
		disableFields(true);
		disableCommandButtons(false,true,true,true,false);
	}
}

function doDelete()
{	
	if(ConfirmMsg(101))
	{	document.forms[0].hidAction.value ="D";
		document.forms[0].hidSourceUrl.value="/action/Duediligence1.jsp";
		document.forms[0].hidBeanId.value="lapsReport";
		document.forms[0].hidBeanMethod.value="updateDueDiligence1";
		document.forms[0].hidBeanGetMethod.value="getDueDiligenceRetail";
		document.forms[0].action=appURL +"controllerservlet";
		document.forms[0].submit(); 
	}	
}

function doSave()
{
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidSourceUrl.value="/action/Duediligence1.jsp";
	document.forms[0].hidBeanId.value="lapsReport";
	document.forms[0].hidBeanMethod.value="updateDueDiligence1";
	document.forms[0].hidBeanGetMethod.value="getDueDiligenceRetail";
	document.forms[0].action=appURL+"controllerservlet";
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
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].disabled=val;
		}		 
	}
}

function callLink(page,bean,method)
{
	document.forms[0].hidSourceUrl.value=page;
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].action=appURL+"action/"+page;
	document.forms[0].submit();
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{		
		if(document.forms[0].hidsaral && document.forms[0].hidsaral.value=="saral")
		{
			document.forms[0].action=appURL+"action/mainnav.jsp";
			document.forms[0].submit();
		}
		else
		{
			document.forms[0].action=appURL+"action/persearch.jsp?&id="+document.forms[0].id.value+"&comapp_compname="+document.forms[0].comapp_compname.value;
			document.forms[0].submit();
		}
	}
}
</script>
</head>
<body onload="onLoading()">
<form name="frmtechins1" action="" method="post" class="normal">
<%if (strSaral.equalsIgnoreCase("saral")) {%>
	 		 <lapschoice:saralreportTag tabid="4" sector="<%=strSector%>"/>
			<lapschoice:inward /> 
	<%}else{%> 
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td id="mainlnk1">
			<jsp:include page="../share/Applurllinkper.jsp" flush="true">
			<jsp:param name="pageid" value="10" />
			</jsp:include>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>		
      <td class="page_flow">Home -&gt; Retail(including schematic) -&gt; Appraisal -&gt; Due Diligence Report -&gt; Due Diligence Report - Salaried</td>
	</tr>
</table>
<lapschoice:application />
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td><jsp:include page="../share/apprlinktab.jsp"
			flush="true">
			<jsp:param name="tabid" value="10" />
		</jsp:include></td>
	</tr>
</table>
<%}%>
<table width="75%" border="0" cellspacing="1" cellpadding="3" class="outertable">
	<tr>
		<td class="sub_tab_active" align="center"><b>Due Diligence Report - Salaried</b></td>		
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','lapsReport','getComDueDiligenceCertificate','com_duediligencecertificate.jsp')" onMouseOut="window.status='';return true;" >Due Diligence Report - Others</a></b></td>
		<td class="sub_tab_inactive" align="center"><b><a href="JavaScript:gotoTab('','lapsReport','getComDueDiligenceReport','com_duediligencereport.jsp')" onMouseOut="window.status='';return true;" >Due Diligence of Properties</a></b></td>
	</tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
  <tr>
   <TD>
    <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
      <tr>
        <td width="2%">1.</td>
        <td width="21%">Name of the Applicant </td>
            <td width="9%"><label> </label></td>
        <td width="68%">
          <input type="text" name="txtName" maxlength="50" size="30" value="<%=Helper.correctNull((String)hshValues.get("strName"))%>"/>        </td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td><input type="hidden" name="txtTitle"  value="<%=Helper.correctNull((String)hshValues.get("strTitle"))%>"/><%=Helper.correctNull((String)hshValues.get("strTitle"))%>&nbsp;</td>
        <td><input type="text" name="txtFatHusName" size="30" maxlength="100" value="<%=Helper.correctNull((String)hshValues.get("strFatHusName"))%>"/></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>Age:</td>
        <td><input type="text" name="txtAge" maxlength="3" onKeyPress="allowNumber(this)" size="5" value="<%=Helper.correctNull((String)hshValues.get("strAge"))%>"/></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td colspan="2">&nbsp;</td>
      </tr>
      <tr>
        <td>2.</td>
        <td>Present Occupation/Employment</td>
        <td colspan="2"><input type="text" name="txtOccupation" maxlength="40" size="50" value="<%=Helper.correctNull((String)hshValues.get("strOccupation"))%>"/></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td colspan="2">&nbsp;</td>
      </tr>
      <tr>
        <td valign="top">3.</td>
        <td>No. of  years in present employment/Organisation<br /> Years:</td>
        <td colspan="2"><input type="text" name="txtYrsemploy" maxlength="3"  size="5" onKeyPress="allowNumber(this)" value="<%=Helper.correctNull((String)hshValues.get("strYrsemploy"))%>"/></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td colspan="2">&nbsp;</td>
      </tr>
      <tr>
        <td>4.</td>
        <td>Whether applicant&rsquo;s services are </td>
        <td colspan="2"><select name="selService">
           <option value="s">----Select----</option>	
          <option value="c">Confirmed</option>
          <option value="u">Unconfirmed</option> </select></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td colspan="2">&nbsp;</td>
      </tr>
      <tr>
        <td valign="top">5.</td>
        <td valign="top">Address of Residence (including Telephone Numbers/Mobile Number and e-mail address</td>
        <td colspan="2"><label>
        <textarea name="txtResiAddr" cols="40" rows="5" onKeyPress="textlimit(this,200)" onkeyup="checkTextArealimit(this,200);"> <%=Helper.correctNull((String)hshValues.get("strResiAddr"))%></textarea>
        </label></td>
        </tr>
      <tr>
        <td valign="top">5.a)</td>
        <td valign="top">Address of Office(including Telephone Numbers/Mobile Number and e-mail address</td>
        <td colspan="2"><textarea name="txtOfficeAddr" cols="40" rows="5" onKeyPress="textlimit(this,200)" onkeyup="checkTextArealimit(this,200);"><%=Helper.correctNull((String)hshValues.get("strOfficeAddr"))%></textarea></td>
        </tr>
    </table>
    </td>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr id="flag"> 
      <td width="33%">&nbsp;</td>
      <td width="33%" align="center"><b> 
        <jsp:include page="../per/Duediligencelink.jsp" flush="true"/>
        </b></td>
      <td width="33%">&nbsp; 
        <div align="right"><b>Pg.1/3  &nbsp;<a href="javascript:callLink('Duediligence2.jsp','lapsReport','getDueDiligenceRetail')"> 
          Next &gt;&gt; </a></b></div>
      </td>
    </tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="hid_appid" value=""> 
<input type="hidden" name="comappid" value="<%=session.getAttribute("comappid")%>">
<!--<input type="hidden" name="appname" value="<%=Helper.correctNull((String)hshValues.get("appname"))%>">-->
<input type="hidden" name="radLoan" value="Y"> 
<input type="hidden" name="prdcode" value="<%=Helper.correctNull((String)hshValues.get("prdcode")) %>"> 
<input type="hidden" name="hidValid" value = "Y">
<input type="hidden" name="auditflag" value = "<%=Helper.correctNull((String)hshValues.get("audit_flag")) %>">
</form>
</body>
</html>
