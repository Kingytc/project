<%@include file="../share/directives.jsp"%>
<%
String strsaral = Helper.correctNull((String)request.getParameter("hidsaral"));
String appstatus=(String)request.getParameter("appstatus");
String strSector=Helper.correctNull((String)request.getParameter("hidsector"));
String strappholder =Helper.correctNull((String)request.getParameter("appholder"));
String strappliedfor=Helper.correctNull((String)request.getParameter("appliedfor"));
String strProposal=Helper.correctNull((String)request.getParameter("hidproposal"));

if(strappliedfor.equalsIgnoreCase(""))
{
	strappliedfor=Helper.correctNull((String)hshValues.get("inward_appliedfor"));
}
//Added by Zahoorunnisa.S for button functionality

String strstatus = Helper.correctNull((String) request.getParameter("hidstatus"));
if (strstatus.equals(""))
    strstatus = Helper.correctNull((String) hshValues.get("status"));

String strSaral = Helper.correctNull((String) request.getParameter("hidsaral"));		
String strapplevel = Helper.correctNull((String)request.getParameter("applevel"));
//end
%>
<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css" />
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>	
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var varright= "<%=Helper.correctNull((String) session.getAttribute("strGroupRights")).charAt(18)%>";
var insbanknameboard="<%=Helper.correctNull((String)hshValues.get("mmr_insbanknameboard"))%>";
var insborrowernamebord="<%=Helper.correctNull((String)hshValues.get("borrower_name"))%>";
var insmaintanance="<%=Helper.correctNull((String)hshValues.get("proper_main"))%>";
var varOrgLevel="<%=strOrgLevel%>";
var varsaral="<%=strsaral%>";
var appstatus="<%=appstatus%>";
function disableCommandButtons(val)
{
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
function callCalender(fname)
{
	if(document.forms[0].cmdsave.disabled==false)
		{
	 		showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	 	}
}
function onLoading()
{

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
	//Added By Zahoorunnisa.S for Button Functionality after discussion with Suresh
	
	//If access through the Loan Application Register and its at Branch 
	if("<%=strSaral%>"=="saral" && "<%=strOrgLevel%>"=="A"){ 
		//If the Application is in open status
		  if("<%=strstatus%>"=="O" && varright=="w"){
		    enableButtons(false,true,true,false,true);
		}else{
			enableButtons(true,true,true,true,true);	
		}
			
	}else if("<%=strSaral%>"=="saral" && "<%=strapplevel%>" == ""){ 
		
		enableButtons(true,true,true,true,true);
			
    }else{
		
		if("<%=strapplevel%>" == "S"){
			enableButtons(true,true,true,true,true);
		}
	}

   
	
	//End

	disableFields(true);
}

function doDelete()
{
	if(ConfirmMsg(101))
	{	
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";		
		document.forms[0].hidBeanMethod.value="updateComInspectionReport";
		document.forms[0].hidBeanGetMethod.value="getComInspectionReport";
		document.forms[0].hidBeanId.value="lapsReport";
		document.forms[0].hidSourceUrl.value="action/com_pre_SanctionInspectionReport.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}
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
		document.forms[0].hidBeanId.value="lapsReport";
		document.forms[0].hidBeanGetMethod.value="getComInspectionReport";
		document.forms[0].action=appUrl +"action/com_pre_SanctionInspectionReport.jsp";
	    document.forms[0].submit();	
	}	
}

function doSave()
{
	if(trim(document.forms[0].txt_visitdate.value)=="")
	{
		alert('Enter Visited Date');
		return;
	}
	if(trim(document.forms[0].txt_name1.value)=="")
	{
		alert("Visited Officer Name");
		return;
	}
	if(trim(document.forms[0].txt_designation1.value)=="")
	{
		alert("Visited Officer Designation");
		return;
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="lapsReport";
	document.forms[0].hidBeanMethod.value="updateComInspectionReport";
	document.forms[0].hidBeanGetMethod.value="getComInspectionReport";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_pre_SanctionInspectionReport.jsp";
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
		
			document.forms[0].elements[i].readOnly=val;
		} 	  
	}
}

function doClose()
{
	if(ConfirmMsg(100))
	{
	    	if(document.forms[0].hidsaral && document.forms[0].hidsaral.value=="saral")
			{
				document.forms[0].action=appUrl+"action/mainnav.jsp";
				document.forms[0].submit();
			}
			else
			{
				document.forms[0].method="post";	
				document.forms[0].action=appURL+"action/corppge.jsp";
				document.forms[0].submit();
			}
	}
}

function callLink(page,bean,method)
{
	if (document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appUrl+"action/"+page;
		document.forms[0].submit();
	}
	else
	{
		ShowAlert(103);
	}
}

function doPrint()
{
	if (("<%=strsaral%>"=="saral"))
	{
		var inwardno=document.forms[0].inwardno.value;
		var varsaral="<%=strsaral%>";
		var appname=document.forms[0].appname.value;
		var hidsector=document.forms[0].hidsector.value;
		var purl = appUrl+"action/com_pre_InspectionReportPrint.jsp?hidBeanGetMethod=getComInspectionReportPrint&hidBeanId=lapsReport&inwardno="+inwardno+"&hidsaral="+varsaral+"&appname="+appname+"&hidsector="+hidsector;
	}
	else
	{
	    var inwardno=document.forms[0].inwardno.value;
		var appno = document.forms[0].strappno.value;
		var purl = appUrl+"action/com_pre_InspectionReportPrint.jsp?hidBeanGetMethod=getComInspectionReportPrint&hidBeanId=lapsReport&appno="+appno+"&inwardno="+inwardno+"&comappid="+document.forms[0].hidapplicantid.value;
	
	}
	prop = "scrollbars=yes,width=700,height=450,statusbar=no,menubar=yes,location=no,toolbar=no";	
	xpos = (screen.width - 700) / 2;
	ypos = (screen.height - 650) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	var title = "Corporate_preinspectionreport";
	window.open(purl,title,prop);
}
function enableButtons(valedit,valsave,valcancel,valdel,valclose)
{
	document.forms[0].cmdedit.disabled=valedit;	  	
	document.forms[0].cmdsave.disabled=valsave;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdclose.disabled=valclose;
}
</script>
</head>
<body onload="onLoading()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>
<form name="frminspection" method="post" class="normal">
<%if (strsaral.equalsIgnoreCase("saral")) {%>
	<lapschoice:saralreportTag tabid="3" sector="<%=strSector%>" applied="<%=strappliedfor%>" proposal="<%=strProposal%>"/>
	<lapschoice:inward /> 
<%} else {%> 
	 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td valign="top"> 
        <jsp:include page="../com/proposallinks.jsp" flush="true"> 
        <jsp:param name="pageid" value="14" />
        <jsp:param name="cattype" value="<%=strCategoryType%>" />
        <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
    </tr>
    <tr>
    	<td class="page_flow">
    	Home -&gt; Corporate & SME -&gt; 
  Proposal -&gt; Credit / Inspection Report -&gt; Inspection
    	</td>
    </tr>
  </table>
  <lapschoice:application /><span style="visibility:hidden;position:absolute"><lapschoice:borrowertype /></span>
	<lapstab:ComReportTab tabid="1" applevel='<%=Helper.correctNull((String)request.getParameter("applevel"))%>' applied='<%=strappliedfor%>' />
	<%}%> 
  <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
    <tr> 
      <td width="24%">Date of visit<span class="mantatory">*&nbsp;</span></td>
      <td width="22%" > 
        <input type="text" name="txt_visitdate" size="15"
			maxlength="25"
			value="<%=Helper.correctNull((String)hshValues.get("visitdate"))%>" onBlur="checkDate(this);checkmaxdate(this,currentDate)">
        <a href="#" onClick="callCalender('txt_visitdate')"
			title="Click to view calender" border=0><img
			src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif" tabindex="2" width="0"
			border="0" ></a></td>
			
      <td width="54%"> 
        <table width="100%" border="0" class="outertable">
  <tr>
            <td width="30%"> Date of report</td>
            <td width="70%"><input type="text" name="txt_reportdate" size="15"
			maxlength="25"
			value="<%=Helper.correctNull((String)hshValues.get("dateofreport"))%>" onBlur="checkDate(this);checkmaxdate(this,currentDate)">
        <a href="#" onClick="callCalender('txt_reportdate')"
			title="Click to view calender"><img
			src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
			border="0" ></a></td>
  </tr>
</table>
			</td>      
    </tr>
    <tr> 
      <td width="24%">Visited by<span class="mantatory">*&nbsp;</span></td>
      <td width="22%">Name</td>
      <td width="54%">Designation</td>
    </tr>
    <tr> 
      <td width="24%">&nbsp;</td>
      <td width="22%"> 
        <input type="text" name="txt_name1" size="35"
			maxlength="25"
			value="<%=Helper.correctNull((String)hshValues.get("visitname1"))%>">
      </td>
      <td width="54%"> 
        <input type="text" name="txt_designation1" size="35"
			maxlength="25" tabindex="3"
			value="<%=Helper.correctNull((String)hshValues.get("visitdes1"))%>">
      </td>
    </tr>
    <tr> 
      <td width="24%">Contact No. of the applicant or key person</td>
      <td width="22%"> 
        <input type="text" name="txt_contact" size="15"
			maxlength="15" tabindex="4" onKeyPress="allowPhone()"
			value="<%=Helper.correctNull((String)hshValues.get("contact"))%>">
      </td>
      <td width="54%">&nbsp; </td>
    </tr>
    <tr> 
      <td width="24%">Distance from branch in Kms</td>
      <td width="22%"> 
        <input type="text" name="txt_distance" size="5"
			maxlength="5" tabindex="5"  onKeyPress="allowNumber(this)"
			value="<%=Helper.correctNull((String)hshValues.get("distance"))%>">
      </td>
      <td width="54%">&nbsp;</td>
    </tr>
    <tr> 
      <td width="24%">Whether new connection or account to be taken-over</td>
      <td width="22%"> 
        <input type="text" name="txt_taken" size="35"
			maxlength="25"
			value="<%=Helper.correctNull((String)hshValues.get("taken"))%>">
      </td>
      <td width="54%">&nbsp; </td>
    </tr>
    <tr> 
      <td width="24%">&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="3"><b>Nearby LandMark for identification</b></td>
    </tr>
    <tr> 
      <td colspan="3"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td width="15%">North</td>
            <td width="32%"> 
              <textarea rows="4" name="txt_north" cols="55" tabindex="8"
					onKeyPress="textlimit(this,3950)" onKeyUp="textlimit(this,3950)"><%=Helper.correctNull((String) hshValues
									.get("north"))%></textarea>
            </td>
            <td width="18%">East</td>
            <td width="35%"> 
              <textarea rows="4" name="txt_east" cols="55" tabindex="9"
					onKeyPress="textlimit(this,3950)" onKeyUp="textlimit(this,3950)"><%=Helper.correctNull((String) hshValues
									.get("east"))%></textarea>
            </td>
          </tr>
          <tr> 
            <td width="15%">West</td>
            <td width="32%"> 
              <textarea rows="4" name="txt_west" cols="55" tabindex="10"
					onKeyPress="textlimit(this,3950)" onKeyUp="textlimit(this,3950)"><%=Helper.correctNull((String) hshValues
									.get("west"))%></textarea>
            </td>
            <td width="18%">South</td>
            <td width="35%"> 
              <textarea rows="4" name="txt_south" cols="55" tabindex="11"
					onKeyPress="textlimit(this,3950)" onKeyUp="textlimit(this,3950)"><%=Helper.correctNull((String) hshValues
									.get("south"))%></textarea>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr> 
      <td colspan="3"> 
        <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr> 
            <td width="15%">Comments on suitability of business premises:</td>
            <td width="32%"> 
              <textarea rows="4" name="txt_suitability" 
					cols="55" tabindex="12" onKeyPress="textlimit(this,3950)" onKeyUp="textlimit(this,3950)"><%=Helper.correctNull((String) hshValues
							.get("suitability"))%></textarea>
            </td>
          </tr>
          <tr> 
            <td width="15%" colspan="2"><b>Observations / Comments of Inspecting 
              officer:</b></td>
          </tr>
          <tr> 
            <td width="15%">Primary Security:</td>
            <td width="32%"> 
              <textarea rows="4" name="txt_primarysecurity" 
					cols="55" tabindex="12" onKeyPress="textlimit(this,3950)" onKeyUp="textlimit(this,3950)"><%=Helper.correctNull((String) hshValues
							.get("primary_security"))%></textarea></td>
            <td width="19%">Collateral Security:</td>
            <td width="34%"> 
              <textarea rows="4" name="txt_collsecurity" cols="55" tabindex="13"
					onKeyPress="textlimit(this,3950)" onKeyUp="textlimit(this,3950)"><%=Helper.correctNull((String) hshValues
							.get("coll_security"))%></textarea>
            </td>
          </tr>
          <tr> 
            <td width="15%">Present status of business activity <br>
              of applicant borrower:</td>
            <td width="32%"> 
              <textarea rows="4" name="txt_presentstatus"
					cols="55" tabindex="14" onKeyPress="textlimit(this,3950)" onKeyUp="textlimit(this,3950)"><%=Helper.correctNull((String) hshValues
							.get("present_status"))%></textarea>
            </td>
            <td width="19%">Availability of infrastructure like Road / Water / 
              Electricity etc.:</td>
            <td width="34%"> 
              <textarea rows="4" name="txt_availability" cols="55" tabindex="15"
					onKeyPress="textlimit(this,3950)" onKeyUp="textlimit(this,3950)"><%=Helper.correctNull((String) hshValues
							.get("availability"))%></textarea>
            </td>
          </tr>
          <tr> 
            <td width="15%">Whether necessary licenses, clearances etc. from statutory 
              Authorities obtained:</td>
            <td width="32%"> 
              <textarea rows="4" name="txt_licenses"
					cols="55" tabindex="14" onKeyPress="textlimit(this,3950)" onKeyUp="textlimit(this,3950)"><%=Helper.correctNull((String) hshValues
							.get("licenses"))%></textarea>
            </td>
            <td width="19%">Comments on operations in the account:</td>
            <td width="34%"> 
              <textarea rows="4" name="txt_operation" cols="55" tabindex="15"
					onKeyPress="textlimit(this,3950)" onKeyUp="textlimit(this,3950)"><%=Helper.correctNull((String) hshValues
							.get("operation"))%></textarea>
            </td>
          </tr>
          <tr> 
            <td width="15%">Whether borrower&#146;s name board is displayed:</td>
            <td width="32%"> 
              <select name="sel_borrowernamebord" tabindex="17">
                <option value="0">--select--</option>
                <option value="1">Yes</option>
                <option value="2">No</option>
              </select>
            </td>
          </tr>
          <tr> 
            <td width="15%">Proper maintenance of books of accounts:</td>
            <td width="32%"> 
              <select name="sel_maintanance" tabindex="18">
                <option value="0">--select--</option>
                <option value="1">Yes</option>
                <option value="2">No</option>
              </select>
            </td>
          </tr>
          <tr> 
            <td width="15%">Comments on credit limits applied for:</td>
            <td width="32%"> 
              <textarea rows="4" name="txt_credit_limit" cols="55" tabindex="19"
					onKeyPress="textlimit(this,3950)" onKeyUp="textlimit(this,3950)"><%=Helper.correctNull((String) hshValues
							.get("credit_limit"))%></textarea>
            </td>
            <td width="19%">Confirmation on Due Diligence / references in any:</td>
            <td width="34%"> 
              <textarea rows="4" name="txt_duediligence" cols="55" tabindex="20"
					onKeyPress="textlimit(this,3950)" onKeyUp="textlimit(this,3950)"><%=Helper.correctNull((String) hshValues
							.get("confirmation"))%></textarea>
            </td>
          </tr>
          <tr> 
            <td width="15%">Any other features observed during inspection:</td>
            <td width="32%" colspan="3"> 
              <textarea rows="4" name="txt_other_features" cols="55" tabindex="19"
					onKeyPress="textlimit(this,3950)" onKeyUp="textlimit(this,3950)"><%=Helper.correctNull((String) hshValues
							.get("other_features"))%></textarea>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
 <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail_Print' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
  <input type="hidden" name="strappno" value="<%=Helper.correctNull((String)request.getParameter("appno"))%>">
</form>
</body>
</html>

