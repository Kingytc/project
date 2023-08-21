<%@include file="../share/directives.jsp"%>
<%
	String strBorrowerType = Helper.correctNull((String) hshValues.get("hidDemoId"));
	String comapp_compname = Helper.correctNull((String) hshValues.get("comapp_compname"));
	String strApplevel=Helper.correctNull((String)request.getParameter("applevel"));
	String strSaral = Helper.correctNull((String) request.getParameter("hidsaral"));
	String strSector=Helper.correctNull((String)request.getParameter("hidsector"));
	String strappliedfor=Helper.correctNull((String)request.getParameter("appliedfor"));	
	ArrayList arryCol = null;
	ArrayList arryRow = (ArrayList) hshValues.get("arrRow");
	 String strapplevel = Helper.correctNull((String)request.getParameter("applevel"));
	  String strstatus = Helper.correctNull((String) request.getParameter("hidstatus"));
		
	    if (strstatus.equals(""))
		    strstatus = Helper.correctNull((String) hshValues.get("status"));
	  
	 
	%>
<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css" />
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="Javascript1.2"><!-- // load htmlarea
_editor_url = "<%=ApplicationParams.getAppUrl()%>";                     // URL to htmlarea files
var win_ie_ver = parseFloat(navigator.appVersion.split("MSIE")[1]);
if (navigator.userAgent.indexOf('Mac')        >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Windows CE') >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Opera')      >= 0) { win_ie_ver = 0; }
if (win_ie_ver >= 5.5) {
  document.write('<scr' + 'ipt src="' +_editor_url+ 'editor.js"');
  document.write(' language="Javascript1.2"></scr' + 'ipt>');  
} else { document.write('<scr'+'ipt>function editor_generate() { return false; }</scr'+'ipt>'); }
// --></script>
<script language="javascript" src= "<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var insbusinessper="<%=Helper.correctNull((String)hshValues.get("ins_businessper"))%>";
var insnatureofbusiness="<%=Helper.correctNull((String)hshValues.get("ins_natureofbusiness"))%>";
var inskycperrelated="<%=Helper.correctNull((String)hshValues.get("ins_kycperrelated"))%>";
var appstatus="<%=Helper.correctNull(request.getParameter("appstatus"))%>";
var varsaral="<%=strSaral%>";
var varOrgLevel="<%=strOrgLevel%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varright= "<%=Helper.correctNull((String) session.getAttribute("strGroupRights")).charAt(18)%>";
function disableCommandButtons(val)
{
	if(val=="load")
	{  
	if(appstatus=="Processed/Rejected" || appstatus=="Processed/Approved" || appstatus=="Closed/Approved" || appstatus=="Closed/Rejected")
	{
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}
	else
		{		
			document.forms[0].cmdedit.disabled=false;
			document.forms[0].cmddelete.disabled=true;
			document.forms[0].cmdsave.disabled=true;
			document.forms[0].cmdcancel.disabled=true;
			document.forms[0].cmdclose.disabled=false;	
		}
		disableFields(true);
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
function callCalender(fname)
 {
	 if(document.forms[0].cmdsave.disabled==false)
	 {
	 showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	 }
 }
function onLoading()
{
if(insbusinessper!=="")
	{
	  document.forms[0].sel_premises.value=insbusinessper;	
	}
	else
	{
		document.forms[0].sel_premises.value='0'
	}
if(insnatureofbusiness!=="")
	{
	  document.forms[0].sel_ownership.value=insnatureofbusiness;	
	}
	else
	{
		document.forms[0].sel_ownership.value='0'
	}
if(inskycperrelated!=="")
	{
	  document.forms[0].sel_related.value=inskycperrelated;	
	}
	else
	{
		document.forms[0].sel_related.value='0'
	}
	

//Added By Zahoorunnisa.S for Button Functionality after discussion with Suresh

if("<%=strSaral%>"=="saral" && "<%=strOrgLevel%>"=="A"){
	
	  if("<%=strstatus%>"=="O" &&  varright=="w"){
	    enableButtons(false,true,true,false,true);
	}else{
		enableButtons(true,true,true,true,true);	
	}
		
}else if("<%=strSaral%>"=="saral" && "<%=strapplevel%>" == ""){ 
	
	enableButtons(true,true,true,true,true,true);
		
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
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg(101))
		{	
			document.forms[0].hidAction.value ="delete";
			document.forms[0].action=appUrl+"action/ControllerServlet";		
			document.forms[0].hidBeanMethod.value="updateOPSInspectionReport";
			document.forms[0].hidBeanGetMethod.value="getOPSInspectionReport";
			document.forms[0].hidBeanId.value="lapsReport";
			document.forms[0].hidSourceUrl.value="action/ops_inspectionreport.jsp";	
			document.forms[0].method="post";			
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
    document.forms[0].hidAction.value ="insert";
	disableCommandButtons("edit");	
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="ops_inspectionreport.jsp";	
		document.forms[0].hidBeanId.value="lapsReport";
		document.forms[0].hidBeanGetMethod.value="getOPSInspectionReport";
		document.forms[0].action=appUrl +"action/ops_inspectionreport.jsp";
	   document.forms[0].submit();	
	}	
	disableCommandButtons("load");
}
function doSave()
	{
		document.forms[0].hidRecordflag.value = varRecordFlag;
	  	document.forms[0].hidBeanId.value="lapsReport";
		document.forms[0].hidBeanMethod.value="updateOPSInspectionReport";
		document.forms[0].hidBeanGetMethod.value="getOPSInspectionReport";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/ops_inspectionreport.jsp";
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
			document.forms[0].elements[i].disabled=val;			
		}
	}
}
function doClose()
{
	var cattype=document.forms[0].cattype.value;
	var id=document.forms[0].id.value;
 		if((cattype=="ASSI")||(cattype=="ASBI")||(cattype=="OPS"))
        {
		   if(ConfirmMsg(100))
			 { 
				document.forms[0].action=appURL+"action/agrborrowersearch.jsp";
				document.forms[0].submit();
			 }
		}
		if((cattype=="SSI")||(cattype=="CORP")||(cattype=="SME"))
        {
        	if(ConfirmMsg(100))
	 			{
					document.forms[0].action=appURL+"action/comsearch.jsp?&id="+document.forms[0].id.value;
					document.forms[0].submit();
	 			}
		}
		if(document.forms[0].hidsaral && document.forms[0].hidsaral.value=="saral")
		{
			if(ConfirmMsg(100))
			 	{ 
				document.forms[0].action=appUrl+"action/mainnav.jsp";
				document.forms[0].submit();
				}
		}
}
function callLink(page,bean,method)
{	
	 if (document.forms[0].cmdapply.disabled)
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
if (("<%=strSaral%>"=="saral"))
	{
		var inwardno=document.forms[0].inwardno.value;
		var varsaral="<%=strSaral%>";
		var appname=document.forms[0].appname.value;
		var hidsector=document.forms[0].hidsector.value;
		var purl = appUrl+"action/ops_inspectionreportprint.jsp?hidBeanGetMethod=getOPSInspectionReport&hidBeanId=lapsReport&inwardno="+inwardno+"&hidsaral="+varsaral+"&appname="+appname+"&hidsector="+hidsector;
	}
	else
	{
		var appno=document.forms[0].appno.value;
		var appname=document.forms[0].appname3.value;
		var inwardno=document.forms[0].inwardno.value;
		var selPrint="Get";
		var purl ="<%=ApplicationParams.getAppUrl()%>action/ops_inspectionreportprint.jsp?hidBeanGetMethod=getOPSInspectionReport&hidBeanId=lapsReport&appno="+appno+"&appname="+appname+"&inwardno="+inwardno;					
	}
		var prop = 'scrollbars=yes,menubar=yes,width=750,height=520';	
		var xpos = (screen.width - 750) / 2;
		var ypos = (screen.height - 520) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,'title',prop);
}
function call_page_diff(url,bean,method)
{	
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url;
	document.forms[0].submit();
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
<form name="frminspection" method="post" class="normal">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
  <tr> 
  <td>
<%if (strSaral.equalsIgnoreCase("saral")) {%>
	 		 <lapschoice:saralreportTag tabid="3" sector='<%=strSector%>' applied='<%=strappliedfor%>' />
			<lapschoice:inward /> 
	<%} else {%>	
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td valign="top" colspan="5">
        <jsp:include page="../share/applurllinkscom.jsp" flush="true">
        <jsp:param name="pageid" value="10" />
        <jsp:param name="cattype" value="<%=strCategoryType%>" />
        <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
    </tr>
    <tr>
    	<td class="page_flow">Home -&gt; Tertiary -&gt; Application -&gt; Reports -&gt; Inspection Report
    	</td>
    </tr>
  </table>
<span style="display:none"><lapschoice:borrowertype /></span>
<lapschoice:application /> 
<lapstab:TerReportTab tabid="2" applevel='<%=strApplevel%>' applied='<%=strappliedfor%>'/>	
<%}%>
</td>
</tr>
</table><br>
<table width="100%" border="1" cellspacing="0" cellpadding="0" class="outertable">
    <tr><td>
  <table width="100%" border="0" cellspacing="3" cellpadding="3" class="outertable">
    <tr> 
      <td width="21%">Date of visit</td>
      <td colspan="2">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="txt_visitdate" size="15"
			maxlength="25"
			value="<%=Helper.correctNull((String)hshValues.get("ins_dateofvisit"))%>" onBlur="checkDate(this);checkmaxdate(this,currentDate)">
        <a href="#" onClick="callCalender('txt_visitdate')"
			title="Click to view calender" border=0><img
			src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif" tabindex="2" width="0"
			border="0" ></a></td>
    </tr>
	<tr>
      <td width="21%">Distance from branch</td>
      <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="txt_distance" tabindex="1" maxlength="25" value="<%=Helper.correctNull((String)hshValues.get("ins_distance"))%>">  </td>
    </tr>
	<tr>
      <td width="21%">Purpose of Loan </td>
      <td colspan="2" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" size="40" name="txt_purpose" tabindex="1" maxlength="100" value="<%=Helper.correctNull((String)hshValues.get("ins_purpose"))%>">  </td>
    </tr>
	<tr>
      <td width="21%"> loan amount requested</td>
      <td colspan="2" ><%=ApplicationParams.getCurrency()%><lapschoice:CurrencyTag  name="txt_loanrequested" tabindex="1" maxlength="15" onKeyPress="allowInteger()" value='<%=Helper.correctNull((String)hshValues.get("ins_amtreqd"))%>' />  </td>
    </tr>
	<tr>
      <td width="21%"> Facility / ies Proposed to be availed from Bank</td>
      <td colspan="2">&nbsp;</td>
    </tr>
    <tr> 
      <td width="21%">Purpose</td>
      <td width="33%">Type of Facility</td>
      <td width="46%">Loan amount requested(Rs) </td>
    </tr>
    <tr> 
	<%for (int i = 1; i < 5; i++) {
				if (arryRow != null && arryRow.size() >= i) {
					arryCol = (ArrayList) arryRow.get(i - 1);
					if (arryCol != null) {%>
      <td width="21%"> 
        <input type="text"  name="txt_facpurpose" size="35"
			maxlength="100" value='<%=Helper.correctNull((String)arryCol.get(2))%>'/>
      </td>
      <td width="33%"> 
        <input type="text"  name="txt_factype" size="50"
			maxlength="100" value='<%=Helper.correctNull((String)arryCol.get(3))%>'/>
      </td>
      <td width="46%"> <lapschoice:CurrencyTag  name="txt_facamount" size="35"
			maxlength="15" tabindex="3" onKeyPress="allowInteger()"
			value='<%=Helper.correctNull((String)arryCol.get(4))%>'/> </td>
    </tr>
		<%}} else {%>
    <tr> 
      <td width="21%"> 
        <input type="text"  name="txt_facpurpose" size="35"
			maxlength="100">
      </td>
      <td width="33%"> 
        <input type="text"  name="txt_factype" size="50"
			maxlength="100" tabindex="4"/>
      </td>
      <td width="46%"> <lapschoice:CurrencyTag  name="txt_facamount" size="35"
			maxlength="15" tabindex="5" onKeyPress="allowInteger()"
			value=''/> </td>
    </tr>
	<%}//end of else
			}//end of for statement
			%>
	  <tr>
      <td width="21%">Business premises is </td>
            
      <td width="33%"> 
        <select name="sel_premises" tabindex="16">
                <option value="0">--select--</option>
                <option value="1">Owned</option>
                <option value="2">Leased</option>
				 <option value="3">Rented</option>
                <option value="4">Others</option>
              </select>
            </td>
          </tr>
		    <tr>            
      <td width="21%">Nature of ownership</td>            
      <td width="33%"> 
        <select name="sel_ownership" tabindex="16">
          <option value="0">--select--</option>
          <option value="1">Free hold</option>
          <option value="2">Lease hold</option>
          <option value="3">Licence</option>
          <option value="4">Undivided share</option>
		   <option value="5">Trust property</option>
          <option value="6">Title only by possession</option>
        </select>
      </td>
          </tr>
	<tr>	   
      <td width="21%">Business Address:</td>            
      <td width="33%"> 
        <textarea rows="4" name="textarea_businessaddr" cols="55" tabindex="9"
					onKeyPress="textlimit(this,99)" onKeyUp="textlimit(this,99)"><%=Helper.correctNull((String) hshValues
									.get("ins_businessaddr"))%></textarea>
      </td>
          </tr>
    <tr> 
      <td colspan="3"> Nearby Landmarks for Identification:</td>
    </tr>
    <tr> 
      <td colspan="3"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td width="15%">North</td>
            <td width="32%"> 
              <textarea rows="4" name="textarea_north" cols="55" tabindex="8"
					onKeyPress="textlimit(this,1499)" onKeyUp="textlimit(this,1499)"><%=Helper.correctNull((String) hshValues.get("ins_landmarknorth"))%></textarea>
            </td>
            <td width="18%">East</td>
            <td width="35%"> 
              <textarea rows="4" name="textarea_east" cols="55" tabindex="9"
					onKeyPress="textlimit(this,1499)" onKeyUp="textlimit(this,1499)"><%=Helper.correctNull((String) hshValues.get("ins_landmarkeast"))%></textarea>
            </td>
          </tr>
          <tr> 
            <td width="15%">West</td>
            <td width="32%"> 
              <textarea rows="4" name="textarea_west" cols="55" tabindex="10"
					onKeyPress="textlimit(this,1499)" onKeyUp="textlimit(this,1499)"><%=Helper.correctNull((String) hshValues.get("ins_landmarkwest"))%></textarea>
            </td>
            <td width="18%">South</td>
            <td width="35%"> 
              <textarea rows="4" name="textarea_south" cols="55" tabindex="11"
					onKeyPress="textlimit(this,1499)" onKeyUp="textlimit(this,1499)"><%=Helper.correctNull((String) hshValues.get("ins_landmarksouth"))%></textarea>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr> 
      <td colspan="3"> 
        <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr> 
            <td width="14%"> Security offered: </td>
            <td width="30%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="14%">Primary Security:</td>
            <td width="30%"> 
              <textarea rows="4" name="txt_primarysecurity" 
					cols="55" tabindex="12" onKeyPress="textlimit(this,999)" onKeyUp="textlimit(this,999)"><%=Helper.correctNull((String) hshValues
							.get("ins_prisecurity"))%></textarea>
            <td width="20%">Collateral Security:</td>
            <td width="36%"> 
              <textarea rows="4" name="txt_collsecurity" cols="55" tabindex="13"
					onKeyPress="textlimit(this,999)" onKeyUp="textlimit(this,999)"><%=Helper.correctNull((String) hshValues
							.get("ins_collsecurity"))%></textarea>
            </td>
          </tr>
          <tr> 
            <td width="14%">Present Banker, if any</td>
            <td width="30%"> 
              <textarea rows="4" name="txt_presentbanker" 
					cols="55" tabindex="12" onKeyPress="textlimit(this,499)" onKeyUp="textlimit(this,499)"><%=Helper.correctNull((String) hshValues
							.get("ins_presentbanker"))%></textarea>
            <td width="20%">&nbsp;</td>
            <td width="36%">&nbsp; </td>
          </tr>
          <tr> 
            <td width="14%"> Loan Outstanding</td>
            <td width="30%">With Other Bank 1</td>
            <td width="20%">&nbsp;</td>
            <td width="36%">With Other Bank 2</td>
          </tr>
          <tr> 
            <td width="14%">Name of the Bank/Branch:</td>
            <td width="30%"> 
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="txt_ourname" tabindex="1" maxlength="250" value="<%=Helper.correctNull((String)hshValues.get("ins_ourbranchname"))%>">
            </td>
            <td width="20%"> Name of the Bank/Branch:</td>
            <td width="36%"> 
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="txt_othername" tabindex="1" maxlength="250" value="<%=Helper.correctNull((String)hshValues.get("ins_othrbankname"))%>">
            </td>
          </tr>
          <tr> 
            <td width="14%">Type of Loan:</td>
            <td width="30%"> 
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="txt_ourtype" tabindex="1" maxlength="200" value="<%=Helper.correctNull((String)hshValues.get("ins_ourloantype"))%>">
            </td>
            <td width="20%">Type of Loan:</td>
            <td width="36%"> 
             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="text" name="txt_othertype" 
			maxlength="200"
			value="<%=Helper.correctNull((String)hshValues.get("ins_othrloantype"))%>" onBlur="">
            </td>
          </tr>
          <tr> 
            <td width="14%"> Amount Sanctioned: </td>
            <td width="30%"><%=ApplicationParams.getCurrency()%><lapschoice:CurrencyTag  name="txt_ouramount" tabindex="1" maxlength="15" onKeyPress="allowInteger()"  value='<%=Helper.correctNull((String)hshValues.get("ins_ouramtsanc"))%>'/> 
            </td>
            <td width="20%"> Amount Sanctioned</td>
            <td width="36%"><%=ApplicationParams.getCurrency()%><lapschoice:CurrencyTag  name="txt_otheramount" tabindex="1" maxlength="15" onKeyPress="allowInteger()"  value='<%=Helper.correctNull((String)hshValues.get("ins_othramtsanc"))%>'/> 
            </td>
          </tr>
          <tr> 
            <td width="14%">Date of Loan:</td>
            <td width="30%"> 
             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="txt_ourdate" size="15" tabindex="1" maxlength="15" onBlur="checkDate(this);checkmaxdate(this,currentDate)" value="<%=Helper.correctNull((String)hshValues.get("ins_ourloandate"))%>">
              <a href="#" onClick="callCalender('txt_ourdate')"
			title="Click to view calender" border=0><img
			src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif" tabindex="2" width="0"
			border="0" ></a> </td>
            <td width="20%"> Date of Loan:</td>
            <td width="36%"> 
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="txt_otherdate"  size="15" tabindex="1" maxlength="15" onBlur="checkDate(this);checkmaxdate(this,currentDate)" value="<%=Helper.correctNull((String)hshValues.get("ins_othrloandate"))%>">
              <a href="#" onClick="callCalender('txt_otherdate')"
			title="Click to view calender" border=0><img
			src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif" tabindex="2" width="0"
			border="0" ></a> </td>
          </tr>
          <tr> 
            <td width="14%">Balance outstanding:</td>
            <td width="30%"><%=ApplicationParams.getCurrency()%><lapschoice:CurrencyTag  name="txt_ourbalance" tabindex="1" maxlength="15" onKeyPress="allowInteger()"  value='<%=Helper.correctNull((String)hshValues.get("ins_ourbalos"))%>'/> 
            </td>
            <td width="20%">Balance outstanding:</td>
            <td width="36%"><%=ApplicationParams.getCurrency()%><lapschoice:CurrencyTag  name="txt_otherbalance" 
			maxlength="15" onKeyPress="allowInteger()" 
			value='<%=Helper.correctNull((String)hshValues.get("ins_othrbalos"))%>'/> 
            </td>
          </tr>
          <tr> 
            <td width="14%"> Overdue if any :</td>
            <td width="30%"><%=ApplicationParams.getCurrency()%><lapschoice:CurrencyTag name="txt_ouroverdue" tabindex="1" maxlength="15"  onKeyPress="allowInteger()"  value='<%=Helper.correctNull((String)hshValues.get("ins_ouroverdue"))%>'/> 
            </td>
            <td width="20%"> Overdue if any </td>
            <td width="36%"><%=ApplicationParams.getCurrency()%><lapschoice:CurrencyTag  name="txt_otheroverdue" tabindex="1" maxlength="15" onKeyPress="allowInteger()"  value='<%=Helper.correctNull((String)hshValues.get("ins_othroverdue"))%>'/> 
            </td>
          </tr>
          <tr> 
            <td width="14%"> <b>Due Diligence:</b></td>
            <td width="30%">&nbsp; </td>
            <td width="20%">&nbsp;</td>
            <td width="36%">&nbsp; </td>
          </tr>
          <tr> 
            <td colspan="2"> <b>A) For KYC Norms</b></td>
            <td width="20%">&nbsp;</td>
            <td width="36%">&nbsp; </td>
          </tr>
          <tr> 
            <td width="14%">Name and Address of person contacted</td>
            <td width="30%"> 
              <textarea rows="4" name="txt_namepersoncond" cols="55" tabindex="19"
					onKeyPress="textlimit(this,999)" onKeyUp="textlimit(this,999)"><%=Helper.correctNull((String) hshValues
							.get("ins_kycpernameaddr"))%></textarea>
            </td>
            <td width="20%"> Whether related to applicant?</td>
            <td width="36%"> 
              <select name="sel_related" tabindex="16">
                <option value="0">--select--</option>
                <option value="1">Yes</option>
                <option value="2">No</option>
              </select>
            </td>
          </tr>
          <tr> 
            <td width="14%"> Since when he/she knows the applicant?</td>
            <td width="30%"> 
              <input type="text" name="txt_sinceappli" tabindex="1" maxlength="60" value="<%=Helper.correctNull((String)hshValues.get("ins_kycpersincewhen"))%>">
            </td>
            <td width="20%"> Since when the applicant is staying at given address?</td>
            <td width="36%"> 
              <input type="text" name="txt_sinceaddress" tabindex="1" maxlength="45" value="<%=Helper.correctNull((String)hshValues.get("ins_appstayinaddr"))%>">
            </td>
          </tr>
          <tr> 
            <td width="14%"> Opinion / Views gathered</td>
            <td colspan="2"> 
              <textarea rows="5" name="textarea_opinion" cols="55" tabindex="19"
					onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("ins_opiniongathered"))%></textarea>
            </td>
            <td width="36%">&nbsp; </td>
          </tr>
          <tr> 
            <td colspan="2" > <b>Property Details</b> </td>
            <td width="20%" >&nbsp;</td>
            <td width="36%" >&nbsp; </td>
          </tr>
          <tr> 
            <td width="14%"> Name and Address of person contacted?</td>
            <td width="30%"> 
              <textarea rows="4" name="textarea_propnamecond" cols="55" tabindex="19"
					onKeyPress="textlimit(this,999)" onKeyUp="textlimit(this,999)"><%=Helper.correctNull((String) hshValues
							.get("ins_proppernameaddr"))%></textarea>
            </td>
            <td width="20%"> Name of the neighbour</td>
            <td width="36%"> 
              <input type="text" name="txt_neig" tabindex="1" maxlength="95" value="<%=Helper.correctNull((String)hshValues.get("ins_propneighbour"))%>">
            </td>
          </tr>
          <tr> 
            <td width="14%"> Whether the properties owned by applicant / guarantor 
              and in their possession?</td>
            <td width="30%"> 
              <textarea rows="4" name="textarea_guarantor" cols="55" tabindex="19"
					onKeyPress="textlimit(this,999)" onKeyUp="textlimit(this,999)"><%=Helper.correctNull((String) hshValues
							.get("ins_propinpossession"))%></textarea>
            </td>
            <td width="20%"> Location of the property is as declared by applicant 
              and prevailing market rate</td>
            <td width="36%"> 
              <textarea rows="4" name="textarea_location" cols="55" tabindex="19"
					onKeyPress="textlimit(this,999)" onKeyUp="textlimit(this,999)"><%=Helper.correctNull((String) hshValues
							.get("ins_proplocation"))%></textarea>
            </td>
          </tr>
		  </table>
		  </td>
		  </tr>
		    <tr> 
      <td colspan="3"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td width="15%"> Observations / Comments of Inspecting officer:</td>
            <td colspan="2"> 
			<textarea
									name="textarea_observation" style="text-align:left" cols="55"
									rows="5" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("ins_officercomments"))%></textarea>
			
			
            </td>
            
            <td width="32%">&nbsp; </td
          ></tr>
        </table>
      </td>
    </tr>
  </table>
  </td>
  </tr>
  </table>
  <br>
  <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Print_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
  <lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hid_appid" value=""> 
<input type="hidden" name="hidValid" value="Y"> 
<input type="hidden" name="id" value="<%=strBorrowerType%>">  
<input type="hidden" name="chkAgri" value=""> 
<input type="hidden" name="chkMinor" value="">
<input type="hidden" name="chkCons" value="<%=Helper.correctNull((String) hshValues.get("perinc_selfincometype"))%>">
<input type="hidden" name="appname3" value="<%=Helper.correctNull((String) hshValues.get("app_name"))%>">
<input type="hidden" name="auditflag" value="<%=Helper.correctNull((String)hshValues.get("audit_flag"))%>">
</form>
</body>
<script language="javascript">
editor_generate('textarea_observation');
editor_generate('textarea_opinion');

</script>
</html>

