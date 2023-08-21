<%@include file="../share/directives.jsp"%>
<%	
	String strSaral = Helper.correctNull((String) request.getParameter("hidsaral"));
	String strSector=Helper.correctNull((String)request.getParameter("hidsector"));
	String strApplevel=Helper.correctNull((String)request.getParameter("applevel"));
	String strappliedfor=Helper.correctNull((String)request.getParameter("appliedfor"));
	if(strappliedfor.equalsIgnoreCase(""))
	{
		strappliedfor = Helper.correctNull((String) hshValues.get("inward_appliedfor"));
	}
	//Added by Zahoorunnisa.S for Button Functionality
	String strAppAtached = Helper.correctNull(request.getParameter("hidappatached"));
	if (strAppAtached.equals(""))
		strAppAtached = Helper.correctNull((String) hshValues.get("appatached"));
	
	String strstatus = Helper.correctNull((String) request.getParameter("hidstatus"));
	if (strstatus.equals(""))
		strstatus = Helper.correctNull((String) hshValues.get("status"));
	
	String strapplevel = Helper.correctNull((String)request.getParameter("applevel"));
	
	String strbtnenable = Helper.correctNull((String)request.getParameter("btnenable"));
	 //End
	
	%>
	
<html>
<head>
<title>Credit Information Report</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css" />
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var apptype = "<%=Helper.correctNull((String) hshValues.get("strAppType"))%>";
var minorchk="<%=Helper.correctNull((String)hshValues.get("CR_Minor"))%>";
var agrchk="<%=Helper.correctNull((String)hshValues.get("CR_Agri"))%>";
var appstatus="<%=Helper.correctNull(request.getParameter("appstatus"))%>";
var varsaral="<%=strSaral%>";	
var attachdetach="<%=Helper.correctNull((String)hshValues.get("attachdetach"))%>";
var varinwardstatus="<%=Helper.correctNull((String)hshValues.get("inwardstatus"))%>";
var varOrgLevel="<%=strOrgLevel%>";
var varconstitution="<%=Helper.correctNull((String)hshValues.get("CR_CONSTITUTION"))%>";
var varright= "<%=Helper.correctNull((String) session.getAttribute("strGroupRights")).charAt(18)%>";
var varstrbtnenable = "<%=strbtnenable%>";
var varstrapplevel = "<%=strapplevel%>";
var varrecordflag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
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
//Added by Zahoorunnisa.S for Button Functionality

function buttonEnable(valnew,valedit,valapply,valcancel,valdel,valclose)
{ 
	document.forms[0].cmdnew.disabled=valnew;
	document.forms[0].cmdedit.disabled=valedit;	  	
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdclose.disabled=valclose;
}
function disableButton(valedit,valapply,valcancel,valdel,valclose)
{
	
	document.forms[0].cmdedit.disabled=valedit;	  	
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdclose.disabled=valclose;
}

//Ended by Zahoorunnisa.S for Button Functionality
function checkVal()
{
	if(document.forms[0].chk_agr.checked==false && document.forms[0].chk_nonagr.checked==false)
	{	
        document.forms[0].chkAgri.value='0';
        document.forms[0].chk_agr.checked=false;
		document.forms[0].chk_nonagr.checked=false;
	}
	
	if(document.forms[0].chk_minor.checked==false && document.forms[0].chk_scst.checked==false)
	{	
		document.forms[0].chkMinor.value='0';
		document.forms[0].chk_scst.checked=false;
		document.forms[0].chk_minor.checked=false;
	}
	
	if(document.forms[0].chk_agr.checked==true)
	{	
        document.forms[0].chkAgri.value='1';
		document.forms[0].chk_nonagr.checked=false;
	}
	if(document.forms[0].chk_nonagr.checked==true)
	{	
		document.forms[0].chkAgri.value='2';
		document.forms[0].chk_agr.checked=false;
	}
	if(document.forms[0].chk_minor.checked==true)
	{	
		document.forms[0].chkMinor.value='1';
		document.forms[0].chk_scst.checked=false;
	}
	if(document.forms[0].chk_scst.checked==true)
	{	
		document.forms[0].chkMinor.value='2';
		document.forms[0].chk_minor.checked=false;
	}
}
function onLoading()
{

	if( varsaral != "saral")
	{
		if(apptype!="")
		{
			document.forms[0].sel_name.value=apptype;
		}
		else
		{
			document.forms[0].sel_name.value='S';
		}
		if(document.forms[0].sel_name.value=='S')
		{
			document.forms[0].txt_fname.value="";
			document.forms[0].txt_offadd.value="";
			document.forms[0].txt_offtel.value="";
			document.forms[0].txt_resadd.value="";
			document.forms[0].txt_restel.value="";
			document.forms[0].txt_permadd.value="";
			document.forms[0].txt_permtel.value="";
		}
	}
	if(minorchk!="")
	{
		if(minorchk=="0")
		{
			document.forms[0].chkMinor.value='0';
			document.forms[0].chk_minor.checked=false;
			document.forms[0].chk_scst.checked=false;
		}
		else if(minorchk=="1")
		{
			document.forms[0].chkMinor.value='1';
			document.forms[0].chk_minor.checked=true;
		}
		else 
		{
			document.forms[0].chkMinor.value='2';
			document.forms[0].chk_scst.checked=true;
		}
	}
	else
	{
		document.forms[0].chk_minor.checked=false;
		document.forms[0].chk_scst.checked=false;
	}
	if(agrchk!="")
	{
		if(agrchk=="0")
		{
			document.forms[0].chkAgri.value='0';
			document.forms[0].chk_agr.checked=false;
			document.forms[0].chk_nonagr.checked=false;
		}
		else if(agrchk=="1")
		{
			document.forms[0].chkAgri.value='1';
			document.forms[0].chk_agr.checked=true;
		}	
		else
		{
			document.forms[0].chkAgri.value='2';
			document.forms[0].chk_nonagr.checked=true;
		}
	}
	else
	{
		document.forms[0].chk_agr.checked=false;
		document.forms[0].chk_nonagr.checked=false;
	}
	if(varconstitution!="")
	{
	document.forms[0].txt_constitution.value=varconstitution;
	}
	
	if (("<%=strSaral%>"=="saral")) 
	{
		document.all.saral.style.visibility="visible";
	 	document.all.saral.style.position="relative";
	 	
	 	document.all.normal.style.visibility="hidden";
	 	document.all.normal.style.position="absolute";
	}
	else if((attachdetach=="attach" && varinwardstatus=='P') && varOrgLevel =='D' && document.forms[0].applevel.value=='S')
	{
		document.all.saral.style.visibility="visible";
	 	document.all.saral.style.position="relative";
	 
	 	document.all.normal.style.visibility="visible";
	 	document.all.normal.style.position="relative";
	}
	else
	{
	 	document.all.saral.style.visibility="hidden";
	 	document.all.saral.style.position="absolute";
	 
	 	document.all.normal.style.visibility="visible";
	 	document.all.normal.style.position="relative";
	}

	//Added By Zahoorunnisa.S for Button Functionality after discussion with Suresh
//Added by Zahoorunnisa.S for Button Functionality
	
	if("<%=strSaral%>"=="saral"){ 
		//If the Application is in open status
		//If access through the Loan Application Register and its at Branch 
	    if("<%=strstatus%>"=="O" && varright=="w" && "<%=strOrgLevel%>"=="A"){
	    	buttonEnable(false,false,true,true,true,false);
	    	
		}else{
			//If access through the Loan Application Register and its at Saral 
			buttonEnable(true,true,true,true,true,false);
			
		}
	    
	}else {
		//If access through the Application wise
		//Access through Branch Users
		if("<%=strOrgLevel%>"=="A" ){
			if(varstrbtnenable == 'N'){
			disableButton(true,true,true,true,false);
         }else{
        	disableButton(false,true,false,false,false);
         }       
		}
		if("<%=strOrgLevel%>"=="D" && "<%=strapplevel%>" == "S"){
			if(attachdetach=="attach" &&  varinwardstatus=='P' && ((appstatus=="op") || (appstatus=="Open/Pending"))){
			//to disable the attach button when the selection option is in "SELECT OPTION"
			
				if(document.forms[0].sel_name.value!='S'){
					document.forms[0].cmdattach.disabled=false;
					document.forms[0].cmdDettach.disabled=true;
					
				}else{
					document.forms[0].cmdattach.disabled=true;
					document.forms[0].cmdDettach.disabled=true;
				}
				
			} else if(attachdetach=="detach" &&  varinwardstatus=='P' && ((appstatus=="op") || (appstatus=="Open/Pending"))){
				
				//to disable the attach button when the selection option is in "SELECT OPTION"
				if(document.forms[0].sel_name.value!='S'){
					document.forms[0].cmdattach.disabled=true;
					document.forms[0].cmdDettach.disabled=false;
					
					
				}else{
					document.forms[0].cmdattach.disabled=true;
					document.forms[0].cmdDettach.disabled=true;
				}
				
			}else{
				
				document.forms[0].cmdattach.disabled=true;
				document.forms[0].cmdDettach.disabled=true;
				
			}
			document.forms[0].cmdsave.disabled=true;
		}		
	}

	//Ended  by Zahoorunnisa.S for Button Functionality
	
	//End
	disableFields(true);
	/****
	*Don't Add any Onload after this
	****/
}
function doEdit()
{ 	
if(varsaral != "saral")
	{
		if(document.forms[0].sel_name.value!='S')
		{
			disableFields(false);
			document.forms[0].hidAction.value ="U";
			//Added by Zahoorunnisa.S for Button Functionality
			disableButton(true,false,false,true,false);
			//Ended by Zahoorunnisa.S for Button Functionality
		}
		else
		{
			alert("Select Name to Edit");
		}
	}
	else
	{
		//Modified by Zahoorunnisa.S for Button Functionality
		if(document.forms[0].txt_crname.value == '' ){
			alert("Select Name to Edit")
		}else{
		 disableFields(false);
		 document.forms[0].hidAction.value ="M";
		 buttonEnable(true,true,false,false,false,false);
		} 
		//Ended by Zahoorunnisa.S for Button Functionality
	}		
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="lapsReport";
		document.forms[0].hidBeanGetMethod.value="getCreditreportforRetail";
		document.forms[0].action=appUrl +"action/ops_creditreport.jsp";
		document.forms[0].submit(); 		
	}
}

function doSave()
{	
		if(document.forms[0].txt_permadd.value=='')
		{
		alert("Enter the Permanent Address");
		return;
		}
		document.forms[0].chkMinor.value=document.forms[0].chkMinor.value;
		document.forms[0].chkAgri.value=document.forms[0].chkAgri.value;
		document.forms[0].hid_appid.value=document.forms[0].sel_name.value;	
		document.forms[0].hidSourceUrl.value="/action/ops_creditreport.jsp";
		document.forms[0].hidBeanId.value="lapsReport";
		document.forms[0].hidBeanMethod.value="updateCreditreport1";
		document.forms[0].hidBeanGetMethod.value="getCreditreportforRetail";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();	
}
function doDelete()
{  	
	if(ConfirmMsg(101))
	{
		document.forms[0].hid_appid.value=document.forms[0].sel_name.value;	
		document.forms[0].hidAction.value ="D";
		document.forms[0].hidSourceUrl.value="/action/ops_creditreport.jsp";
		document.forms[0].hidBeanId.value="lapsReport";
		document.forms[0].hidBeanMethod.value="updateCreditreport1";
		document.forms[0].hidBeanGetMethod.value="getCreditreportforRetail";
		document.forms[0].action=appUrl +"controllerservlet";
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
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].disabled=val;
		} 
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		} 
	}
	if(varsaral != "saral")
	{
	document.forms[0].sel_name.disabled=false;
	}
	document.forms[0].chk_minor.disabled=val;
	document.forms[0].chk_scst.disabled=val;
	document.forms[0].chk_agr.disabled=val;
	document.forms[0].chk_nonagr.disabled=val;
}
function callLink(page,bean,method)
{
	 //Added by Zahoorunnisa.S for Button Functionality
	if (varsaral  == '' && varOrgLevel  == 'D' && varstrapplevel=='S'){ 
		document.forms[0].cmdsave.disabled=true;
	}
	//Ended by Zahoorunnisa.S for Button Functionality
	if(varrecordflag=="Y") {	
		if(document.forms[0].cmdsave.disabled==true) {
			if(varsaral != "saral") {
				if(document.forms[0].sel_name.value=='S') {
				alert("Select Name");
				return;
			}
			document.forms[0].hid_appid.value=document.forms[0].sel_name.value;	
		} else {
			if(document.forms[0].txt_crname.value=='') {
			alert("Select Name");
			return;
			}
		}			
			document.forms[0].hidSourceUrl.value=page;
			document.forms[0].hidBeanGetMethod.value=method;
			document.forms[0].hidBeanId.value=bean;
			document.forms[0].action=appUrl+"action/"+page;
			document.forms[0].submit();
	} else {
	ShowAlert(103);
	   }
	 }else {
	if (varsaral  == '' && varOrgLevel  == 'D' && varstrapplevel=='S'){ 
	  alert('Attach the Report for further processing');	
	}else{
	  alert('Press Edit and Save for further processing');
	return;
	}
}	
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{		
			if(document.forms[0].hidsaral && document.forms[0].hidsaral.value=="saral")
			{
				document.forms[0].action=appUrl+"action/mainnav.jsp";
				document.forms[0].submit();
			}
			else
			{
				document.forms[0].action=appUrl+"action/agrborrowersearch.jsp";
				document.forms[0].submit();
			}
	}
}	
function getValues()
{
	document.forms[0].hidAction.value="Get";
	document.forms[0].hid_appid.value=document.forms[0].sel_name.value;	
	document.forms[0].hidBeanId.value="lapsReport";
	document.forms[0].hidBeanGetMethod.value="getCreditreportforRetail";
	document.forms[0].action=appURL+"action/ops_creditreport.jsp";
	document.forms[0].submit();
}
function call_page_diff(url,bean,method)
{	
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url;
	document.forms[0].submit();
}
function enableButtons(valnew,valattach,valdetach,valedit,valapply,valcancel,valdel,valclose)
{
	document.forms[0].cmdnew.disabled=valnew;
	document.forms[0].cmdattach.disabled=valattach;
	document.forms[0].cmdDettach.disabled=valdetach;
	document.forms[0].cmdedit.disabled=valedit;	  	
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdclose.disabled=valclose;
}
function doNew()
{
	disableFields(false);
	document.forms[0].hidAction.value ="I";
	document.forms[0].chkMinor.value="0";
	document.forms[0].chkAgri.value="0";
	document.forms[0].txt_crname.value="";
	document.forms[0].hid_slno.value="";
	document.forms[0].txt_fname.value="";
	document.forms[0].txt_offadd.value="";
	document.forms[0].txt_offtel.value="";
	document.forms[0].txt_resadd.value="";
	document.forms[0].txt_restel.value="";
	document.forms[0].txt_permadd.value="";
	document.forms[0].txt_permtel.value="";
	document.forms[0].txt_mainbussiness.value="";
	document.forms[0].txt_sideline.value="";
	document.forms[0].txt_constitution.value="0";
	document.forms[0].txt_established.value="";
	//Added by Zahoorunnisa.S for Button Functionality
	buttonEnable(true,true,false,false,true,false);
	//Ended by Zahoorunnisa.S for Button Functionality
}
function showCreditReport()
{
	//Modified by Zahoorunnisa.S for Button Functionality
	if((varsaral != 'saral' && varOrgLevel != 'D')) {
	if(document.forms[0].cmdsave.disabled == true && document.forms[0].cmdedit.disabled == false) {
		var varinwardno = document.forms[0].inwardno.value;
		var varQryString = "<%=ApplicationParams.getAppUrl()%>action/creditreportsearch.jsp?hidBeanId=lapsReport&hidBeanGetMethod=getCreditreportNames&inwardno="+varinwardno;
		var title = "SearchCreditReportName";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=350,top=50";
		window.open(varQryString,title,prop);
	}
   }else{
	    var varinwardno = document.forms[0].inwardno.value;
		var varQryString = "<%=ApplicationParams.getAppUrl()%>action/creditreportsearch.jsp?hidBeanId=lapsReport&hidBeanGetMethod=getCreditreportNames&inwardno="+varinwardno;
		var title = "SearchCreditReportName";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=350,top=50";
		window.open(varQryString,title,prop);

  }  
  //Ended by Zahoorunnisa.S for Button Functionality
}
function doAttach(action)
{
	
		if(document.forms[0].txt_crname.value!="")
		{
		document.forms[0].hid_appid.value=document.forms[0].sel_name.value;	
		document.forms[0].hidattach.value = action;
		document.forms[0].hidAction.value="Get";
	    document.forms[0].hidSourceUrl.value="/action/ops_creditreport.jsp";
		document.forms[0].hidBeanId.value="lapsReport";
		document.forms[0].hidBeanMethod.value="AttachDetachCreditReport";
		document.forms[0].hidBeanGetMethod.value="getCreditreportforRetail";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();
		}
		else
		{
		alert("Select a name for attaching");
		document.forms[0].txt_crname.focus();
		}
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body onload="onLoading()">
<form name="frmcredit1" action="" method="post" class="normal">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
  <tr> 
  <td>  
  
   <%if (strSaral.equalsIgnoreCase("saral")) {%>
	 		 <lapschoice:saralreportTag tabid="2" sector='<%=strSector%>' applied='<%=strappliedfor%>' />
			<lapschoice:inward /> 
	<%} else {%> 
	<table width="100%" border="0" cellspacing="0" cellpadding="0" >
    <tr> 
      <td valign="top" colSpan=5>
        <jsp:include page="../share/applurllinkscom.jsp" flush="true">
        <jsp:param name="pageid" value="10" />
        <jsp:param name="cattype" value="<%=strCategoryType%>" />
        <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
    </tr>
    <tr>
    	<td class="page_flow">Home -&gt; Tertiary -&gt; Application -&gt; Reports -&gt; Credit Report
    	</td>
    </tr>
  </table>
  <span style="display:none"><lapschoice:borrowertype /></span>
	<lapschoice:application /> 
	<lapstab:TerReportTab tabid="1" applevel='<%=strApplevel%>' applied='<%=strappliedfor%>' />
	<%}%>
  </td>
 </tr>
</table>
<br>
<table width="100%" border="1" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td> 
<table width="100%" border="0" cellspacing="2" cellpadding="2" class="outertable">
    <tr> 
      <td> 
        <table width="100%" border="0" class="outertable">
          <tr> 
            <td COLSPAN="2" id="normal"><b> Name :</b> 
              <select name="sel_name"
			onchange="getValues()">
                <option value="S" selected>&lt;----Select----&gt;</option>
                <lapschoice:tertiarypromoter />
              </select>
            </td>
            <td id="saral"> <b>Name: </b> 
              <input type="text" name="txt_crname" size="50" maxlength="80" 
					value="<%=Helper.correctNull((String)hshValues.get("CR_NAME"))%>" >
              <span onClick="showCreditReport()" style="cursor:hand"><img
					alt="Click to Search"
					src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
					border="0" tabindex="36"></span> </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr> 
      <td COLSPAN="2">&nbsp;</td>
    </tr>
    <tr>
      <td COLSPAN="2"><table width="100%" border="0" class="outertable">
  <tr>
            <td width="11%">Nature of Main Business</td>
            <td width="45%"> 
              <textarea name="txt_mainbussiness" cols="30" onKeyPress="textlimit(this,399)" onKeyUp="textlimit(this,399)"><%=Helper.correctNull((String)hshValues.get("CR_MAINBUSSINESS"))%></textarea>
            </td>
	        <td width="9%">Side Lines if any</td>
            <td width="35%"> 
              <textarea name="txt_sideline" cols="30" onKeyPress="textlimit(this,399)" onKeyUp="textlimit(this,399)"><%=Helper.correctNull((String)hshValues.get("CR_SIDELINE"))%></textarea>
            </td>
  </tr>
</table>
</td>
    </tr>
     <tr> 
      <td COLSPAN="2">&nbsp;</td>
    </tr>
	<tr> 
      <td COLSPAN="2">
        <table width="100%" border="0" class="outertable">
          <tr id="constitution"> 
            <td width="21%" >Constitution 
              <select name="txt_constitution">
                <option value="0">---Select-----</option>
                <%String apptypecon = "14";%>
                <lapschoice:StaticDataNewTag apptype='<%=apptypecon%>' /> 
              </select>
            </td>
            <td width="7%" >Established
              <input type="text" name="txt_established" size="30" maxlength="15" 
					value="<%=Helper.correctNull((String)hshValues.get("CR_ESTABLISHED"))%>" >
            </td>
           
          </tr>
          <tr> 
            <td width="21%"> 
              <INPUT TYPE="checkbox" NAME="chk_agr" STYLE="border-style:none"
			VALUE="0" onClick="checkVal()">
              Agriculturist</td>
            <td width="42%"> 
              <INPUT TYPE="checkbox" NAME="chk_minor" STYLE="border-style:none"
			VALUE="0" onClick="checkVal()">
              Minority</td>
          </tr>
          <tr> 
            <td width="21%"> 
              <INPUT TYPE="checkbox" NAME="chk_nonagr" STYLE="border-style:none"
			VALUE="0" onClick="checkVal()">
              Non-Agriculturist</td>
            <td width="42%"> 
              <INPUT TYPE="checkbox" NAME="chk_scst" STYLE="border-style:none"
			VALUE="0" onClick="checkVal()">
              SC/ST</td>
          </tr>
        </table>
      </td>
    </tr>
	<tr> 
      <td COLSPAN="2">&nbsp;</td>
    </tr>
    <tr> 
      <td COLSPAN="2">&nbsp;</td>
    </tr>
    <tr> 
      <td COLSPAN="2">Full name of identical, connected or associated firms giving 
        the nature and place of business name(s) of their bankers with address/es 
        and details of credit facilities allowed by them.</td>
    </tr>
    <tr> 
      <td COLSPAN="2">Full names &amp; address of the individual, proprietor, 
        partners, karta and co-parceners, directors, etc. and their relationship 
        with each other. If any (brief report on the business means/assets of 
        partners/directors to be given on the reverse)</td>
    </tr>
    <tr> 
      <td COLSPAN="2"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable linebor">
          <tr class="dataheader"> 
            <td rowspan="2" width="20%"><B> Father s Name</B></td>
            <td colspan="6" align="center"><B>Address with Telephone Number</B></td>
          </tr>
          <tr class="dataheader"> 
            <td align="center" width="13%">Office</td>
            <td align="center" width="11%">Tel.No.</td>
            <td align="center" width="12%">Residence</td>
            <td align="center" width="13%">Tel.No.</td>
            <td align="center" width="17%">Permanent Address *</td>
            <td align="center" width="14%">Tel. No.</td>
          </tr>
          <tr class="datagrid">            
            <td width="20%" align="center">
              <input type="text" name="txt_fname"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("CR_FatName"))%>"
					maxlength="25">
            </td>
            <td width="13%" align="center">&nbsp; 
              <textarea cols="26" rows="5" onKeyPress="textlimit(this,999)" onKeyUp="textlimit(this,999)"
					name="txt_offadd"><%=Helper.correctNull((String) hshValues
								.get("CR_Offadd"))%></textarea>
            </td>
            <td width="11%" align="center">&nbsp; 
              <input type="text"
					name="txt_offtel" onKeyPress="allowPhone()" maxlength="15"
					value="<%=Helper.correctNull((String) hshValues.get("CR_OffTelno"))%>">
            </td>
            <td width="12%" align="center">&nbsp; 
              <textarea cols="26" rows="5"
					name="txt_resadd" onKeyPress="textlimit(this,999)" onKeyUp="textlimit(this,999)"><%=Helper.correctNull((String) hshValues
								.get("CR_Resadd"))%></textarea>
            </td>
            <td width="13%" align="center">&nbsp; 
              <input type="text"
					name="txt_restel" onKeyPress="allowPhone()" maxlength="15"
					value="<%=Helper.correctNull((String) hshValues.get("CR_ResTelno"))%>">
            </td>
            <td width="17%" align="center">&nbsp; 
              <textarea cols="26" rows="5"
					name="txt_permadd" onKeyPress="textlimit(this,999)" onKeyUp="textlimit(this,999)"><%=Helper.correctNull((String) hshValues
								.get("CR_Permadd"))%></textarea>
            </td>
            <td width="14%" align="center">&nbsp; 
              <input type="text"
					name="txt_permtel" onKeyPress="allowPhone()" maxlength="15"
					value="<%=Helper.correctNull((String) hshValues.get("CR_PermTelno"))%>">
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  </td>
  </tr>
  </table><br>
<table width="12%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr>
		<td>
		<table width="50%" border="0" cellspacing="0" cellpadding="2" class="outertable">
			<tr>
		  <!-- Modified By Zahoorunnisa.S for Altering the Button Functionality after discussion with SureshKumar -->
                   
					 <%--  <td align="center" id="idnew">
					<input type="button" name="cmdnew" value="New" class="buttonStyle" onclick="doNew()">
					</td> --%>
					 <% if (strSaral.equalsIgnoreCase("") && strOrgLevel.equalsIgnoreCase("D") && strapplevel.equalsIgnoreCase("S")){ %>
					<td align="center" id="idattach">
					<input type="button"
						name="cmdattach" value="Attach" class="buttonStyle"
						onclick="doAttach('attach')"></td>
					<td align="center" id="iddeattach"><input type="button"
						name="cmdDettach" value="Detach" class="buttonStyle"
						onclick="doAttach('detach')"></td>
						<td align="center" >
					<input type="hidden" name="cmdsave" value="Save" class="buttonStyle" onclick="doSave()">
					</td>
				 <%} %>
				    <% if (strSaral.equalsIgnoreCase("saral")){ %>
		              <td align="center"  id="idnew">
		                <lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
					</td>
					<% } else if(!strOrgLevel.equalsIgnoreCase("D")){%>
					 <td align="center"  id="idedit">
                     <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
				     <input type="hidden" name="cmdnew" value="New" class="buttonStyle" onclick="doNew()">
				   </td>
					<%} %>
					
					<!-- End -->
					
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
	<tr>
		<td width="33%">&nbsp;
		<div align="right"><b>Pg.1/2
		&nbsp;<a
			href="javascript:callLink('ops_creditreportmeans.jsp','lapsReport','getCreditreport2')"
			> Next &gt;&gt; </a></b></div>
		</td>
	</tr>
</table>
<br />
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hid_appid" value=""> 
<input type="hidden" name="hidValid" value="Y"> 
<input type="hidden" name="chkMinor" value="">
<input type="hidden" name="chkAgri" value="">
<input type="hidden" name="chkCons" value="<%=Helper.correctNull((String) hshValues.get("perinc_selfincometype"))%>">
<input type="hidden" name="hid_slno" value="<%=Helper.correctNull((String)hshValues.get("CR_SLNO"))%>">
<input type="hidden" name="hidattach">
</form>
</body>
</html>


