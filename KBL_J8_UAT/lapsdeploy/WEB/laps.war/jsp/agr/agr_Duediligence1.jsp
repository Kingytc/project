<%@include file="../share/directives.jsp"%>

<%
String comapp_compname =Helper.correctNull((String)hshValues.get("comapp_compname"));
String strSaral = Helper.correctNull((String) request.getParameter("hidsaral"));
String strSector=Helper.correctNull((String)request.getParameter("hidsector"));
//Added by Zahoorunnisa.S for button functionality

String strstatus = Helper.correctNull((String) request.getParameter("hidstatus"));
if (strstatus.equals(""))
	strstatus = Helper.correctNull((String) hshValues.get("status"));
String strapplevel = Helper.correctNull((String)request.getParameter("applevel"));			
	//end	
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Duediligence Report</title>

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var recflag="<%=Helper.correctNull((String)hshValues.get("recordflag"))%>";
var selService="<%=Helper.correctNull((String)hshValues.get("strService"))%>";
var varright= "<%=Helper.correctNull((String) session.getAttribute("strGroupRights")).charAt(18)%>";
currentDate = "<%=Helper.getCurrentDateTime()%>";
var varOrgLevel="<%=strOrgLevel%>";
function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;		 
	}
	
	if(val=="edit")
	{	 
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=false;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
}
function onLoading()
{	
	
	//if(appstatus !="op")
//	{
	//		document.forms[0].cmdedit.disabled=true;
	//		document.forms[0].cmdsave.disabled=true;
	//		document.forms[0].cmdcancel.disabled=true;
	//		document.forms[0].cmddelete.disabled=true;
	//}
//	else
//	{
	//disableCommandButtons("load");
//	}
	
   //Added By Zahoorunnisa.S for Button Functionality after discussion with Suresh
	
	//If access through the Loan Application Register and its at Branch 
	if("<%=strSaral%>"=="saral" && "<%=strOrgLevel%>"=="A"){ 
		//If the Application is in open status
		if("<%=strstatus%>"=="O"  &&  varright=="w"){
		    enableButtons(false,true,true,false,true);
		}else{
			enableButtons(true,true,true,true,true);	
		}
			
	}else if("<%=strSaral%>"=="saral" && "<%=strapplevel%>" == ""){ 
		
		enableButtons(true,true,true,true,true,true);
			
    }else{
		
		//Access through Branch Users
		if("<%=strapplevel%>" == "S"){
			enableButtons(true,true,true,true,true);
		}
	}

   
	//End
	
	 disableFields(true);
}
function doEdit()
{ 
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	disableCommandButtons("edit");		
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{

		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="lapsReport";		
		document.forms[0].hidBeanGetMethod.value="getDueDiligence";
		document.forms[0].hidSourceUrl.value="/action/agr_Duediligence1.jsp";
		document.forms[0].submit();

	}	
	
	disableCommandButtons("load");
}
function doDelete()
{	
		if(ConfirmMsg(101))
		{
			document.forms[0].hidAction.value ="delete";
			document.forms[0].hidSourceUrl.value="/action/agr_Duediligence1.jsp";
			document.forms[0].hidBeanId.value="lapsReport";
			document.forms[0].hidBeanMethod.value="updateAgriDueDiligence";
			document.forms[0].hidBeanGetMethod.value="getDueDiligence";
			document.forms[0].action=appURL +"controllerservlet";
			document.forms[0].submit(); 
		}
	
}

function doSave()
	{
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidSourceUrl.value="/action/agr_Duediligence1.jsp";
	document.forms[0].hidBeanId.value="lapsReport";
	document.forms[0].hidBeanMethod.value="updateAgriDueDiligence";
	document.forms[0].hidBeanGetMethod.value="getDueDiligence";
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
				document.forms[0].target="_parent";		
				document.forms[0].action=appURL+"action/retailpge.jsp";
				document.forms[0].submit();
			}
	}
}
function callCalender(fname)
 {
 	if(document.forms[0].cmdsave.disabled!=true)
	{
	 showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	}
 }
 
function doPrint()
{
	if(("<%=strSaral%>"=="saral"))
		{
			var inwardno=document.forms[0].inwardno.value;
			var varsaral="<%=strSaral%>";
			var appname=document.forms[0].appname.value;
			var hidsector=document.forms[0].hidsector.value;
		    var orgname=document.forms[0].orgname.value;
			var purl="<%=ApplicationParams.getAppUrl()%>action/agr_Duediligence_print.jsp?hidBeanGetMethod=getDueDiligence&hidBeanId=lapsReport&inwardno="+inwardno+"&hidsaral="+varsaral+"&appname="+appname+"&hidsector="+hidsector+"&orgname="+orgname;
		}
	else
		{
			var appno=document.forms[0].appno.value;
			var orgname=document.forms[0].orgname.value;
			var inwardno=document.forms[0].inwardno.value;
			var purl="<%=ApplicationParams.getAppUrl()%>action/agr_Duediligence_print.jsp?hidBeanGetMethod=getDueDiligence&hidBeanId=lapsReport&appno="+appno+"&orgname="+orgname+"&inwardno="+inwardno;
		}
	prop='scrollbars=yes,menubar=yes,width=750,height=520';
	xpos=(screen.width-750)/2;
	ypos=(screen.height-520)/2;
	prop=prop+",xpos="+xpos+",ypos="+ypos;
	window.open(purl,'Agriculture_Duediligence_print',prop);
}

function enableButtons(valedit,valapply,valcancel,valdel,valclose)
{
	document.forms[0].cmdedit.disabled=valedit;	  	
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdclose.disabled=valclose;
}
</script>
</head>

<body onload="onLoading()">
<form name="frmtechins1" action="" method="post" class="normal">
<%if (strSaral.equalsIgnoreCase("saral")) {%>
	 		 <lapschoice:saralreportTag tabid="4" sector='<%=strSector%>'/>
			<lapschoice:inward/> 
			<%}%>
<table width="95%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable border1">
 
  <tr>

    <td>
        <table width="100%" border="0" cellspacing="0" align="center" cellpadding="3" class="outertable">
          <tr> 
            <td colspan="3">Name of the Applicant </td>
            
            <td colspan="4"> 
              <input type="text" name="txtName" size="30" value="<%=Helper.correctNull((String)hshValues.get("dueName"))%>"/>
            </td>
          </tr>
		  <tr> 
            <td colspan="7">&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="4"><font face="MS Sans Serif" size="1"><b>A. &nbsp;&nbsp;&nbsp;For KYC Norms</b></font></td>
          </tr>
          <tr> 
            <td width="3%">a.</td>
            <td colspan="2">Name and address of person contacted</td>
            <td width="65%"> 
              <textarea name="txtPersonContact" cols="50" rows="5" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("duePersonContact"))%></textarea>
            </td>
          </tr>
          <tr> 
            <td width="3%">b.</td>
            <td colspan="2">Whether related to applicant?</td>
            <td width="65%" > 
              <input type="text" name="txtRelated" size="50" value="<%=Helper.correctNull((String)hshValues.get("dueapplntrelated"))%>"/>
            </td>
          </tr>
          <tr> 
            <td width="3%">c.</td>
            <td colspan="2">Since when he knew the applicant ? </td>
            <td width="65%" > 
              <input type="text" name="txtSincewhen" size="50" value="<%=Helper.correctNull((String)hshValues.get("dueknewsince"))%>"/>
            </td>
          </tr>
          <tr> 
            <td width="3%">d.</td>
            <td colspan="2">Since when applicant is staying at given address ?</td>
            <td width="65%" > 
              <textarea name="txtYrsofResidence" cols="50" rows="5" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("dueYrsofResidence"))%></textarea>
            </td>
          </tr>
		  <tr> 
            <td colspan="7">&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="4"><font face="MS Sans Serif" size="1"><b>B.&nbsp;&nbsp;&nbsp;For property 
              details (Preferably from Talati / VAO / existing customer ) </b></font></td>
          </tr>
		  <tr> 
            <td colspan="7">&nbsp;</td>
          </tr>
          <tr> 
            <td width="3%">a.</td>
            <td colspan="2">Brief description of the property (Location,survey 
              no.,village ,area,approx.value of the property) </td>
            <td colspan="2" valign="top" width="65%"> 
              <textarea name="txtResiaddrVisited" cols="50" rows="5" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("dueResiaddrVisited"))%></textarea>
            </td>
          </tr>
          <tr> 
            <td width="3%">&nbsp;</td>
            <td colspan="3">&nbsp;</td>
          </tr>
          <tr> 
            <td  width="3%">b.</td>
            <td colspan="2" >Whether offered property/ies is/are occupied by owner 
              or tenant ?</td>
            <td colspan="2" width="65%"> 
              <textarea name="txtTypeofResidence" cols="50" rows="5" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("dueTypeofResidence"))%></textarea>
            </td>
          </tr>
          <tr> 
            <td width="3%">&nbsp;</td>
            <td colspan="3">&nbsp;</td>
          </tr>
          <tr> 
            <td width="3%">c.</td>
            <td colspan="2">Comments on marketability of the property </td>
            <td colspan="2" width="65%"> 
              <textarea name="txt_marketability" cols="50"
									rows="5" wrap="VIRTUAL" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
									.get("duemarketability"))%></textarea>
            </td>
          </tr>
          <tr> 
            <td width="3%">&nbsp;</td>
            <td colspan="3">&nbsp;</td>
          </tr>
          <tr> 
            <td width="3%">d.</td>
            <td colspan="2">Observations of inspecting officers</td>
            <td colspan="2" width="65%"> 
              <textarea name="txt_observation" cols="50"
									rows="5" wrap="VIRTUAL" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("dueobservations"))%></textarea>
            </td>
          </tr>
          <tr> 
            <td colspan="5">&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="5"> </td>
          </tr>
          <tr> 
            <td colspan="2"> 
              <table width="23%" border="0" align="center"  class="outertable">
                <tr> 
                  <td width="6%">Date:</td>
                  <td width="20%"> 
                    <input type="text" name="txt_date"
									value="<%=Helper.correctNull((String)hshValues.get("duedatevisit"))%>"
									onBlur="checkDate(this);checkmaxdate(this,currentDate)" />
                  </td>
                  <td width="6%"><a alt="Select date from calender" href="#"
									onClick="callCalender('txt_date')"
									onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"> 
                    <img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
									alt="Select date from calender" /></a></td>
                </tr>
              </table>
            </td>
            <td width="65%" align="center">Name of the Inspecting officers: &nbsp; 
              <input type="text" name="txt_inspecting"
									value="<%=Helper.correctNull((String)hshValues.get("dueinspectorname"))%>"
									 />
            </td>
         
            <td width="65%">Designation: &nbsp; 
              <input type="text" name="txt_inspectingdesign"
									value="<%=Helper.correctNull((String)hshValues.get("dueinspectordesign"))%>" />
            </td>
          </tr>
          <tr> 
            <td colspan="4">&nbsp;</td>
          </tr>
        </table>
      </td>
  </tr>
  
</table>
<br>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Print" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br>

<input type="hidden" name="hid_appid" value=""> 
<input type="hidden" name="prdcode" value="<%=Helper.correctNull((String)hshValues.get("prdcode")) %>"> 
<input type="hidden" name="hidValid" value = "Y">
<input type="hidden" name="orgname" value="<%=Helper.correctNull((String)session.getAttribute("strOrgName"))%>"/>
<%-- 
<input type="hidden" name="hid_pagename" value=""> 
<input type="hidden" name="id" value="<%=strBorrowerType%>">	
<input type="hidden" name="hidDemoId" value="<%=Helper.correctNull((String)session.getAttribute("hidDemoId"))%>">
<input type="hidden" name="hid_id" value="<%=session.getAttribute("strUserId")%>"> 
<input type="hidden" name="appname" value="<%=Helper.correctNull((String)hshValues.get("appname"))%>">
<input type="hidden" name="comappid" value="<%=session.getAttribute("comappid")%>">
<input type="hidden" name="txt_comappid" value="<%=Helper.correctNull((String)hshValues.get("applicantid"))%>">
<input type="hidden" name="applicationnumber" value="<%=(String)request.getParameter("appno")%>"> 
--%>
   <input type="hidden" name="comapp_compname" value="<%=comapp_compname%>">	
   <%if(strSaral.equals("saral")){
	   %>
	<lapschoice:hiddentag /> 
<%}else{
	%>
<lapschoice:agrihiddentag /> 
<%} %>

</form>
</body>
<script language="javascript1.2">
if(parent.menuFrame && parent.mainFrame)
{
	if(parent.menuFrame.document.forms[0].applevel && parent.mainFrame.document.forms[0].applevel)
	{
		parent.mainFrame.document.forms[0].applevel.value=parent.menuFrame.document.forms[0].applevel.value;
	}
	if(parent.menuFrame.document.forms[0].btnenable && parent.mainFrame.document.forms[0].btnenable)
	{
		parent.mainFrame.document.forms[0].btnenable.value=parent.menuFrame.document.forms[0].btnenable.value;
	}
}

</script>
</html>
