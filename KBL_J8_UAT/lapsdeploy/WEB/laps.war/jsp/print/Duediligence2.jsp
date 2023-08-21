<%@include file="../share/directives.jsp"%>
<%
String strSaral = Helper.correctNull((String) request.getParameter("hidsaral"));
String strSector=Helper.correctNull((String)request.getParameter("hidsector"));
String strappholder =Helper.correctNull((String)request.getParameter("appholder"));

//Added by Zahoorunnisa.S for button functionality
String strapplevel = Helper.correctNull((String)request.getParameter("applevel"));
String strstatus = Helper.correctNull((String) request.getParameter("hidstatus"));
if (strstatus.equals(""))
	strstatus = Helper.correctNull((String) hshValues.get("status"));
//End
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";

var varpageid="<%=Helper.correctNull((String) hshValues.get("PageId"))%>";
var appstatus="<%=Helper.correctNull(request.getParameter("appstatus"))%>";

var varpageid="<%=Helper.correctNull((String) hshValues.get("PageId"))%>";
var varOrgLevel="<%=strOrgLevel%>";		
var varright= "<%=Helper.correctNull((String) session.getAttribute("strGroupRights")).charAt(18)%>";
function disableCommandButtons(cmdedit,cmdsave,cmdcancel,cmdclose)
{
		 	document.forms[0].cmdedit.disabled=cmdedit;
			document.forms[0].cmdsave.disabled=cmdsave;
			document.forms[0].cmdcancel.disabled=cmdcancel;
			document.forms[0].cmdclose.disabled=cmdclose;
}
function onLoading()
{
	//If access through the Loan Application Register and its at Branch 
	if("<%=strSaral%>"=="saral" && "<%=strOrgLevel%>"=="A"){ 
		//If the Application is in open status
		if("<%=strstatus%>"=="O" && varright=="w"){
		    enableButtons(false,true,true,false,false);
		}else{
			enableButtons(true,true,true,true,false);	
		}
			
	}else if("<%=strSaral%>"=="saral" && "<%=strapplevel%>" == ""){ 
		
		enableButtons(true,true,true,true,false);
			
    }else{
		
		if("<%=strapplevel%>" == "S"){
			enableButtons(true,true,true,true,false);
		}
	}

  
	//End
	disableFields(true);
}
function doEdit()
{ 	
	document.forms[0].hidAction.value ="U";
	disableCommandButtons(true,false,false,true);
	disableFields(false);
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{

		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="lapsReport";		
		document.forms[0].hidBeanGetMethod.value="getDueDiligenceRetail";
		document.forms[0].action=appURL+"action/Duediligence2.jsp";	
		document.forms[0].submit();

	}	
	
	if(appstatus=="Processed/Rejected" || appstatus=="Processed/Approved" || appstatus=="Closed/Approved" || appstatus=="Closed/Rejected")
	{
		disableFields(true);
		disableCommandButtons(true,true,true,false);
	}	
	else
	{
			disableFields(true);
			disableCommandButtons(false,true,true,false);
	}
}

/*function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="/action/Duediligence2.jsp";
		document.forms[0].hidBeanId.value="lapsReport";
		document.forms[0].hidBeanGetMethod.value="getDueDiligenceRetail";
		document.forms[0].hidBeanMethod.value="getDueDiligenceRetail";
		document.forms[0].action=appURL +"controllerservlet";
		document.forms[0].submit(); 		
	}	
	
	disableCommandButtons("load");
}
*/
function doSave()
	{
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidSourceUrl.value="/action/Duediligence2.jsp";
	document.forms[0].hidBeanId.value="lapsReport";
	document.forms[0].hidBeanMethod.value="updateDueDiligence2";
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
			document.forms[0].elements[i].readOnly=true;
		}	
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
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
if(ConfirmMsg('100'))
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
function enableButtons(valedit,valapply,valcancel,valdel,valclose)
{
	document.forms[0].cmdedit.disabled=valedit;	  	
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	//document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdclose.disabled=valclose;
}
</script>
</head>

<body onload="onLoading()">
<form name="form1" action="" method="post" class="normal">
<%if (strSaral.equalsIgnoreCase("saral")) {%>
	 		 <lapschoice:saralreportTag tabid="4" sector="<%=strSector%>"/>
			<lapschoice:inward /> 
	<%} 
else 
{
%>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable linebor">
	<tr>
		<td id="mainlnk1"><jsp:include page="../share/Applurllinkper.jsp"
			flush="true">
			<jsp:param name="pageid" value="10" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		
      <td class="pagepathheader"><b><i>Home -&gt; Retail -&gt; 
        <%=(String) session.getAttribute("pgeLabel")%> -&gt; Appraisal -&gt; Due Diligence
        Report </i></b></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td id="mainlnk1"><lapschoice:application /></td>
	</tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable linebor">
	<tr>
		<td><jsp:include page="../share/apprlinktab.jsp"
			flush="true">
			<jsp:param name="tabid" value="10" />
		</jsp:include></td>
	</tr>
</table>
<%} %>
<table width="75%" border="0" cellspacing="3" cellpadding="5"	class="outertable">
	<tr>
	<td class="sub_tab_active" align="center">
			<b>
				Due Diligence Report - Salaried
			</b>
		</td>
		
	<td class="sub_tab_inactive" align="center">
			<b>
				<a href="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','lapsReport','getComDueDiligenceCertificate','com_duediligencecertificate.jsp')" onMouseOut="window.status='';return true;" >Due Diligence Report - Others</a>
			</b>
		</td>
		<td class="sub_tab_inactive" align="center">
			<b>
				<a href="JavaScript:gotoTab('<%//=ApplicationParams.getAppUrl()%>','lapsReport','getComDueDiligenceReport','com_duediligencereport.jsp')" onMouseOut="window.status='';return true;" >Due Diligence of Properties</a>
			</b>
		</td>
		
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
  <!-- <tr>
    <td align="center">
      <strong>UNION  BANK OF INDIA</strong></td>

  </tr>
  <tr>
    <td align="center">&nbsp;</td>
  </tr>
  <tr>
    <td align="center"><strong>RETAIL BANKING DEPARTMENT<br />
      CENTRAL OFFICE<br />
    MUMBAI</strong></td>

  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>SALARIED PERSONS:</td>
  </tr>
  <tr>

    <td>&nbsp;</td>
  </tr> -->
  <tr>
    <td>Before answering the following questions, mention the sources of information and name of person (s) contacted.</td>
  </tr>
  <tr>
    <td><textarea name="txtPersonContact" cols="50" rows="5" onKeyPress="textlimit(this,3999)" onkeyup="checkTextArealimit(this,3999);"/><%=Helper.correctNull((String)hshValues.get("strPersonContact"))%></textarea></td>
  </tr>

  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
      <tr>
        <td width="2%" valign="top">1.</td>
        <td width="33%" valign="top">Whether the residential address given by applicant is visited ?  if so when ? Whether address matches with that given in the application? Give land mark for identifying the address and enclose rough sketch of location.</td>

            <td width="65%">
              <textarea name="txtResiaddrVisited" cols="50" rows="5" onKeyPress="textlimit(this,3999)" onkeyup="checkTextArealimit(this,3999);"/><%=Helper.correctNull((String)hshValues.get("strResiaddrVisited"))%></textarea>
            </td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>

        <td valign="top">2.</td>
        <td valign="top">Since how many years the applicant is residing at the given address of residence?</td>
        <td><textarea name="txtYrsofResidence" cols="50" rows="5" onKeyPress="textlimit(this,3999)" onkeyup="checkTextArealimit(this,3999);"/><%=Helper.correctNull((String)hshValues.get("strYrsofResidence"))%></textarea></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>

        <td>&nbsp;</td>
      </tr>
      <tr>
        <td valign="top">3.</td>
        <td valign="top">Whether the residence is owned/rented/leased/company provided. </td>
        <td><textarea name="txtTypeofResidence" cols="50" rows="5" onKeyPress="textlimit(this,3999)" onkeyup="checkTextArealimit(this,3999);"/><%=Helper.correctNull((String)hshValues.get("strTypeofResidence"))%></textarea></td>
      </tr>

      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td valign="top">4.</td>
        <td valign="top">Whether address of  Office/Business Place is visited ? If so when? Whether the address on physical inspection matches with that of address given in the application? Give land mark for identifying location.</td>

        <td><textarea name="txtOfficeaddrVisited" cols="50" rows="5" onKeyPress="textlimit(this,3999)" onkeyup="checkTextArealimit(this,3999);"/><%=Helper.correctNull((String)hshValues.get("strOfficeaddrVisited"))%></textarea></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>

        <td valign="top">5.</td>
        <td valign="top">Whether identity of the applicant (s) is/are established through telephonic enquiry? If the date, time and the telephone numbers.</td>
        <td><textarea name="txtIdentity" cols="50" rows="5" onKeyPress="textlimit(this,3999)" onkeyup="checkTextArealimit(this,3999);"/><%=Helper.correctNull((String)hshValues.get("strIdentity"))%></textarea></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>

        <td>&nbsp;</td>
      </tr>
      <tr>
        <td valign="top">5.</td>
        <td valign="top">Whether genuineness of salary certificate ( in the case of employees ) submitted by the applicant is verified with the employer ( say Yes or No) </td>
        <td><textarea name="txtGenuineSC" cols="50" rows="5" onKeyPress="textlimit(this,3999)" onkeyup="checkTextArealimit(this,3999);"/><%=Helper.correctNull((String)hshValues.get("strGenuineSC"))%></textarea></td>
      </tr>

    </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>

	<lapschoice:combuttonnew
			btnnames='Edit_Save_Cancel'
			btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
			
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr> 
      <td width="33%" align="left"><b>&nbsp;
        <a href="javascript:callLink('Duediligence1.jsp','lapsReport','getDueDiligenceRetail')" > 
           &lt;&lt; Prev </a>&nbsp;Pg.2/3 </b>
      </td>
      <td width="33%" align="center"><b> 
        <jsp:include page="../per/Duediligencelink.jsp" flush="true"/> 
        </b></td>
      <td width="33%">&nbsp; 
        <div align="right"><b>Pg.2/3  &nbsp;<a href="javascript:callLink('Duediligence3.jsp','lapsReport','getDueDiligenceRetail')" > 
          Next &gt;&gt; </a></b></div>
      </td>
    </tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>

  <input type="hidden" name="radLoan" value="Y"> 
 <%-- 
   <input type="hidden" name="hid_pagename" value="" />
 --%>
</form>

</body>
</html>
