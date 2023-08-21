<%@include file="../share/directives.jsp"%>

<%
	
	ArrayList arrRow=new ArrayList();
	ArrayList arrCol=new ArrayList();
	if(hshValues!=null)
	{
	arrRow = (ArrayList)hshValues.get("arrRow");
	}
	%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Short Note</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" 	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<link rel="stylesheet" href="../htm/link.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js"></script>

<script>	
var currentDate="<%=Helper.getCurrentDateTime()%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";

 

function callCalender1(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);
	}
}

	function doEdit() 
	{
		callDisable(false);
		document.forms[0].hidAction.value="Update";
		disableControls(true,false,false);	
	
		
		document.forms[0].txt_inwardrefno.readOnly=true;
		document.forms[0].txt_inwarddate.readOnly=true;
		document.forms[0].sel_type.readOnly=true;
		document.forms[0].txt_solid.readOnly=true;
		document.forms[0].txt_BranchName.readOnly=true;
		document.forms[0].txt_RegionName.readOnly=true;
		document.forms[0].txt_custid.readOnly=true;
		document.forms[0].txt_BorrowerName.readOnly=true;
		document.forms[0].txt_duedatewc.readOnly=true;
		document.forms[0].txt_droppeddate.readOnly=true;
		document.forms[0].txt_sanctiondate.readOnly=true;
		document.forms[0].txt_deferreddate.readOnly=true;
		document.forms[0].txt_lodgedate.readOnly=true;
		document.forms[0].txt_loanprocessofficername.readOnly=true;
		document.forms[0].txt_TAT.readOnly=true;
		funchkforstatus();
		document.forms[0].sel_exposurebracket.disabled=true;
	}

	function doCancel()
	{
		
		if(ConfirmMsg('102'))
		{
			document.forms[0].action=appURL+"action/shortnotes.jsp";
			document.forms[0].hidBeanId.value = "lapsReport";
			document.forms[0].hidBeanGetMethod.value = "getinwardoutwardshortnotedetails";
			document.forms[0].submit();
		}
		
	}
	function callonLoad()
	{
		callDisable(true);
		disableControls(true,true,true);	
	}
	
	function disableControls(cmdEdit,cmdApply,cmdCancel)
	{
		document.forms[0].cmdedit.disabled=cmdEdit;
		document.forms[0].cmdsave.disabled=cmdApply;
		document.forms[0].cmdcancel.disabled=cmdCancel;
	}

	function callDisable(one)
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
			  document.forms[0].elements[i].readOnly=one;
			}
			if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=one;
			}
			if(document.forms[0].elements[i].type=="select-one")
			{
				document.forms[0].elements[i].disabled=one;
			}
			
		}
		
		
	}

function doClose()
{
	if(ConfirmMsg(100))
	 {
	   document.forms[0].action=appURL+"action/inwardoutward.jsp";
	   document.forms[0].submit();
	 }
}
/*function getinwarddetails(fbilldata)
{
	
	var tenordateval=fbilldata.value;
	//alert(tenordateval);
	if(tenordateval !="")
		{
	document.all.ifrm1.src=appURL+"action/iframeforgetinwarddetails.jsp?hidBeanGetMethod=getinwarddetails&hidBeanId=lapsReport&inwardno="+document.forms[0].txt_inwardrefno.value;
		}
}*/
function showAckSearch()
{		
	
		var varQryString = appURL+"action/searchinwradno.jsp?hidBeanId=lapsReport&hidBeanGetMethod=getinwarddetails&Category=shortnotes";
		var title = "Acknowledgement";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);	
}

function palceValues(val0,val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12
		,val13,val14,val15,val16,val17,val18,val19,val20,val21,val22,val23,val24,val25,val26,val27,val28)
{
	document.forms[0].txt_inwardrefno.value=val0;
	document.forms[0].txt_inwarddate.value=val1;
	document.forms[0].sel_type.value=val2;
	document.forms[0].txt_solid.value=val3;
	document.forms[0].txt_BranchName.value=val4;
	document.forms[0].txt_RegionName.value=val5;
	document.forms[0].txt_custid.value=val6;
	document.forms[0].txt_BorrowerName.value=val7;
	document.forms[0].txt_proposedfblimit.value=val8;
	document.forms[0].txt_proposednfblimit.value=val9;
	document.forms[0].txt_totalexposure.value=val10;
	document.forms[0].sel_exposurebracket.value=val11;
	
	document.forms[0].sel_proposedhandledat.value=val12;
document.forms[0].txt_loanprocessofficername.value=val13;
document.forms[0].sel_proposalstatus.value=val14;
document.forms[0].txt_TAT.value=val15;
document.forms[0].txt_remarks.value=val16;
	document.forms[0].sel_proposal.value=val17;
document.forms[0].txt_duedatewc.value=val18;
document.forms[0].sel_sanctioningauth.value=val19;
document.forms[0].txt_sanctionrefno.value=val20;
document.forms[0].txt_sanctiondate.value=val21;
document.forms[0].txt_lodgerefno.value=val22;
document.forms[0].txt_lodgedate.value=val23;
document.forms[0].txt_droppedrefno.value=val24;
document.forms[0].txt_droppeddate.value=val25;
document.forms[0].txt_deferreddetails.value=val26;
document.forms[0].txt_deferreddate.value=val27;
document.forms[0].activity_flagin_proposal.value=val28;

	disableControls(false,true,true);
	
	document.all.applsearch.style.visibility="hidden";
	document.all.applsearch.style.position="absolute";
	callDisable(true);
	funchkforstatus();
	
}

function doSave()  
{
	if(document.forms[0].txt_inwardrefno.value=="")
		{
		ShowAlert(121,"Inward Ref No");
		document.forms[0].txt_inwardrefno.focus();
		return;
		}
	if(document.forms[0].txt_proposedfblimit.value=="")
	{
	ShowAlert(121,"Proposed FB Limit");
	document.forms[0].txt_proposedfblimit.focus();
	return;
	}
	if(document.forms[0].txt_proposednfblimit.value=="")
	{
	ShowAlert(121,"Proposed NFB Limit");
	document.forms[0].txt_proposednfblimit.focus();
	return;
	}
	if(document.forms[0].txt_totalexposure.value=="")
	{
	ShowAlert(121,"Total Exposure");
	document.forms[0].txt_totalexposure.focus();
	return;
	}
	if(document.forms[0].sel_proposedhandledat.value=="0")
	{
	ShowAlert(121,"Proposed Handled at");
	document.forms[0].sel_proposedhandledat.focus();
	return;
	}
	if(document.forms[0].txt_loanprocessofficername.value=="")
	{
	ShowAlert(121,"	Loan Processing Officer Name");
	document.forms[0].txt_loanprocessofficername.focus();
	return;
	}
	if(document.forms[0].sel_proposalstatus.value=="0")
	{
	ShowAlert(121,"	Status of Proposal");
	document.forms[0].sel_proposalstatus.focus();
	return;
	}
	if(document.forms[0].sel_proposal.value=="0")
	{
		ShowAlert(121,"	Type of Proposal");
		document.forms[0].sel_proposal.focus();
		return;
	}
	if(document.forms[0].sel_proposal.value!="1")
	{
	  if(document.forms[0].txt_duedatewc.value=="")
		  {
		  ShowAlert(121,"Due Date of WC");
			document.forms[0].txt_duedatewc.focus();
			return;
		  }
	}
	if(document.forms[0].sel_proposalstatus.value=="6")
	{
	 if(document.forms[0].txt_sanctionrefno.value=="" || document.forms[0].txt_sanctiondate.value=="")
		 {
		 alert("Please enter Sanction Date and Sanction Ref no");
		 return;
		 }
	}
if(document.forms[0].sel_proposalstatus.value=="7")
{
 if(document.forms[0].txt_lodgerefno.value=="" || document.forms[0].txt_lodgedate.value=="")
	 {
	 alert("Please enter Lodge Date and Lodge Ref No");
	 return;
	 }
}
if(document.forms[0].sel_proposalstatus.value=="8")
{
 if(document.forms[0].txt_droppedrefno.value=="" || document.forms[0].txt_droppeddate.value=="")
	 {
	 alert("Please enter Dropped Reference No and Dropped Date");
	 return;
	 }
}
	document.forms[0].exposurebracket.value=document.forms[0].sel_exposurebracket.value
	document.forms[0].cmdsave.disabled = true;	
	document.forms[0].hidBeanId.value="lapsReport";	
	document.forms[0].hidBeanMethod.value="updateinwardoutwardshortnotedetails";
	document.forms[0].hidBeanGetMethod.value="getinwardoutwardshortnotedetails";
	document.forms[0].hidSourceUrl.value="/action/shortnotes.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function callUsersHelp1()
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var varQryString = appURL+"action/setUserSearch.jsp?pagefrom=inwardoutwardproposal";
		var title = "Users";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}
}
function chkExposure(obj)
{
	if(parseFloat(obj.value)<5)
		{
		document.forms[0].sel_exposurebracket.value="1";
		}
	else if(parseFloat(obj.value)>=5 && parseFloat(obj.value)<=15 )
		{
		document.forms[0].sel_exposurebracket.value="2";
		}
	else if(parseFloat(obj.value)>15)
		{
		document.forms[0].sel_exposurebracket.value="3";
		}
}
function funchkforstatus()
{
	if(document.forms[0].sel_proposalstatus.value=="6")
		{
		document.forms[0].txt_sanctionrefno.disabled=false;
		document.forms[0].txt_sanctiondate.disabled=false;
		document.all.iddatepickerforsan.style.visibility="visible";
		document.all.iddatepickerforsan.style.position="relative";
		
		document.forms[0].txt_lodgerefno.disabled=true;
		document.forms[0].txt_lodgedate.disabled=true;
		document.all.iddatepickerforlodge.style.visibility="hidden";
		document.all.iddatepickerforlodge.style.position="absolute";
		document.forms[0].txt_lodgerefno.value="";
		document.forms[0].txt_lodgedate.value="";
		
		document.forms[0].txt_droppedrefno.disabled=true;
		document.forms[0].txt_droppeddate.disabled=true;
		document.all.iddatepickerfordropped.style.visibility="hidden";
		document.all.iddatepickerfordropped.style.position="absolute";
		document.forms[0].txt_droppedrefno.value="";
		document.forms[0].txt_droppeddate.value="";
		}
	else if(document.forms[0].sel_proposalstatus.value=="7")
		{
		document.forms[0].txt_lodgerefno.disabled=false;
		document.forms[0].txt_lodgedate.disabled=false;
		document.all.iddatepickerforlodge.style.visibility="visible";
		document.all.iddatepickerforlodge.style.position="relative";
		
		document.forms[0].txt_sanctionrefno.disabled=true;
		document.forms[0].txt_sanctiondate.disabled=true;
		document.all.iddatepickerforsan.style.visibility="hidden";
		document.all.iddatepickerforsan.style.position="absolute";
		document.forms[0].txt_sanctionrefno.value="";
		document.forms[0].txt_sanctiondate.value="";
		
		document.forms[0].txt_droppedrefno.disabled=true;
		document.forms[0].txt_droppeddate.disabled=true;
		document.all.iddatepickerfordropped.style.visibility="hidden";
		document.all.iddatepickerfordropped.style.position="absolute";
		document.forms[0].txt_droppedrefno.value="";
		document.forms[0].txt_droppeddate.value="";
		}
	else if(document.forms[0].sel_proposalstatus.value=="8")
		{
		document.forms[0].txt_droppedrefno.disabled=false;
		document.forms[0].txt_droppeddate.disabled=false;
		document.all.iddatepickerfordropped.style.visibility="visible";
		document.all.iddatepickerfordropped.style.position="relative";
		
		document.forms[0].txt_sanctionrefno.disabled=true;
		document.forms[0].txt_sanctiondate.disabled=true;
		document.all.iddatepickerforsan.style.visibility="hidden";
		document.all.iddatepickerforsan.style.position="absolute";
		document.forms[0].txt_sanctionrefno.value="";
		document.forms[0].txt_sanctiondate.value="";
		
		document.forms[0].txt_lodgerefno.disabled=true;
		document.forms[0].txt_lodgedate.disabled=true;
		document.all.iddatepickerforlodge.style.visibility="hidden";
		document.all.iddatepickerforlodge.style.position="absolute";
		document.forms[0].txt_lodgerefno.value="";
		document.forms[0].txt_lodgedate.value="";
		}
	else
		{
		document.forms[0].txt_sanctionrefno.disabled=true;
		document.forms[0].txt_sanctiondate.disabled=true;
		document.all.iddatepickerforsan.style.visibility="hidden";
		document.all.iddatepickerforsan.style.position="absolute";
		document.forms[0].txt_sanctionrefno.value="";
		document.forms[0].txt_sanctiondate.value="";
		
		document.forms[0].txt_lodgerefno.disabled=true;
		document.forms[0].txt_lodgedate.disabled=true;
		document.all.iddatepickerforlodge.style.visibility="hidden";
		document.all.iddatepickerforlodge.style.position="absolute";
		document.forms[0].txt_lodgerefno.value="";
		document.forms[0].txt_lodgedate.value="";
		
		document.forms[0].txt_droppedrefno.disabled=true;
		document.forms[0].txt_droppeddate.disabled=true;
		document.all.iddatepickerfordropped.style.visibility="hidden";
		document.all.iddatepickerfordropped.style.position="absolute";
		document.forms[0].txt_droppedrefno.value="";
		document.forms[0].txt_droppeddate.value="";
		
		}
}
function DisableCopyPastealert(e) 
{
 // Message to display
 var message = "Insert key and Right Click Option is disabled";
 // check mouse right click or Ctrl key press
var kCode = e.keyCode; 
//FF and Safari use e.charCode, while IE use e.keyCode
 if (kCode == 17 || kCode == 0 || kCode == 45)
 {
 alert(message);
 return false;
 }
 else{
	 allowNumeric(kCode)
 }
}
function specialcharalert(event) {
	//alert("alert2");
	  var x = event.which || event.keyCode;
	  
	  /*if((x>=65 && x<=90)||(x>=97 && x<=122)||(x>=48 && x<=57)|| x==32)
	  {
		  return true;
	  }
	  else
	  {
		  alert("Only allow for Alphabet and Numbers")
		  return false;
		    
	  }*/
	       if(x==34||x==39)
		  {
		   alert("Double or single quotes not allowed");
		   return false;
		  }
	       else
	    	   {
	    	   return true;
	    	   }
	  
	}
	
function allowalwysOldDate(obj,mindate)
{
	var pagedate=obj.value;
	var pgdt=changeDateformat(pagedate);
	var mindt=changeDateformat(mindate);
	var varc = changeDateformat(currentDate);
	if(obj.value!="")
	{
		if(Date.parse(pgdt) < Date.parse(mindt))
		{
			alert("Date Can not be less than Inward Date as " + mindate);
			obj.value="";
			obj.focus();
			return false;
		}
	}
	if(Date.parse(pgdt) > Date.parse(varc))
	{
		alert("Date Can not be future date");
		obj.value="";
		obj.focus();
		return false;
	}
		
		
	return true;
}
function futureDate(obj)
{
	var pagedate=obj.value;
	var pgdt=changeDateformat(pagedate);
	var varc = changeDateformat(currentDate);
	if(obj.value!="")
	{
	
	if(Date.parse(pgdt) > Date.parse(varc))
	{
		alert("Date Can not be future date");
		obj.value="";
		obj.focus();
		return false;
	}
	}
		
		
	return true;
}
</script>
</head>
<body onload="callonLoad();">
<form class="normal" method="post">


<table width="95%" border="1" cellspacing="0" cellpadding="3"
	class="outertable" align="center" style="margin-left: 20px; margin-right: 20px; margin-top: 5px;">
<tr>
<td>
<table class="outertable" width="100%"  border="0" cellspacing="0" cellpadding="3" align="center">

	<tr class="dataheader" style="text-align: center">
		<td style="text-align: center;width:100%;">Short Note</td><td></td>	
	</tr>
</table>	
<table class="outertable" width="100%"  border="0" cellspacing="0" cellpadding="3" align="center">	
	<tr>
		<td width="10%">Inward Ref No</td>
		 <td width="20%"><input type="text" name="txt_inwardrefno" value="">
		 <span id="applsearch"  onClick="showAckSearch()"
													style="cursor:hand"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0" ></span></td>
		<td width="15%">Inward Date</td>
		 <td width="15%"><input type="text" name="txt_inwarddate" size="12"
							maxlength="10" 
							value=""
							onBlur="checkDate(this);">
					                                  </td>
							
		<td width="20%">Type of Borrower</td>
		 <td width="15%"> <select name="sel_type">
								          <option value="0" selected="selected">&lt;---Select---&gt;</option>
								          <option value="1">NTB</option>
								          <option value="2">ETB</option>
								           <option value="3">Others</option>
								        </select></td>
							        
		</tr>
	<tr>
		<td>Sol ID</td>
		 <td><input type="text" name="txt_solid"  value=""></td>
		<td>Branch Name</td>
		 <td><input type="text" name="txt_BranchName"  value=""></td>
							
		<td>Region Name</td>
		<td> <input type="text" name="txt_RegionName"   value="" ></td>
				
	</tr>
	<tr>
		<td>Cust ID</td>
		 <td><input type="text" name="txt_custid"   value="">
		</td>
		<td>Borrower Name</td>
		 <td><input type="text" name="txt_BorrowerName"  value=""></td>
								
		<td>Proposed FB Limit (Rs. in Cr)</td>
		<td><input type="text" name="txt_proposedfblimit"   value=""></td>
	<tr>
		<td>Proposed NFB Limit (Rs. in Cr)</td>
		 <td> <input type="text" name="txt_proposednfblimit"   value=""></td>
		<td>Total Exposure(Rs in Cr)</td>
		 <td> <input type="text" name="txt_totalexposure" onBlur="chkExposure(this);"   value=""></td>
		<td>Exposure Bracket</td>
		 <td>
		  <select name="sel_exposurebracket">
								          <option value="0" selected="selected">&lt;---Select---&gt;</option>
								          <option value="1">Below 5 Cr</option>
								          <option value="2">5-15 Cr</option>
								           <option value="3">Above 15 Cr</option>	
			</select>					           
	</tr>	
	<tr>
		<td>Proposed Handled at</td>
		 <td>  <select name="sel_proposedhandledat">
								          <option value="0" selected="selected">&lt;---Select---&gt;</option>
								          <option value="M">Mangaluru</option>
								          <option value="B">Bengaluru</option>								          
				</select>					           
		 </td>
		<td>Loan Processing Officer Id - Name</td>
		 <td> <input type="text" name="txt_loanprocessofficername"  maxlength="30" value="">
		 <span onClick="callUsersHelp1()" style="cursor: hand"><img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" tabindex="81"></span></td>
		<td>Status of Proposal</td>
		<td>  <select name="sel_proposalstatus" onchange="funchkforstatus();">
								          <option value="0" selected="selected">&lt;---Select---&gt;</option>
								          <option value="1">Query yet to be raised</option>
								          <option value="2">Reply yet to be received</option>	
								           <option value="3">Under circulation</option>	
								           <option value="4">Partial reply received</option>	
								              <option value="5">Under Process</option>	
								              <option value="6">Sanctioned</option>		
								              <option value="7">Lodged</option>		
								                <option value="8">Dropped</option>								          
				</select>
		</td>		
	</tr>	
	<tr>
		<td>TAT</td>
		 <td> <input type="text" name="txt_TAT"  maxlength="50" value=""></td>
		<td>Remarks</td>
		 <td> 
		 <textarea name="txt_remarks" onKeyDown="return DisableCopyPastealert(event)" onkeypress="return specialcharalert(event)" maxlength="3999"  cols="46" rows="2"></textarea></td>
		<td>Type of Proposal</td>
		 <td>
		 <select name="sel_proposal">
								          <option value="0" selected="selected">&lt;---Select---&gt;</option>
								          <option value="1">Fresh</option>
								          <option value="2">Renewal</option>
								           <option value="3">Renewal with Enhancement</option>
		</select>
		</td>
	</tr>
	<tr>							        
		<td>Due Date of WC</td>
		 <td><input type="text" name="txt_duedatewc" size="15"
							maxlength="15" 
							value=""
							onBlur="checkDate(this);">
							 <a href="#"
							onClick="callCalender1('txt_duedatewc')"
								onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0"></a>
			</td>
		<td>Sanctioning Authority</td>
		 <td>
		 <select name="sel_sanctioningauth">
								          <option value="0" selected="selected">&lt;---Select---&gt;</option>
								          <option value="CM">CM</option>
								          <option value="AGM">AGM</option>
								           <option value="DGM">DGM</option>
							               <option value="GM">GM</option>
							               <option value="CBO">CBO</option>
							               <option value="ED">ED</option>
							               <option value="MD">MD</option>
							               <option value="MCB">MCB</option>
							               <option value="B">Board</option>
		</select>
		</td>
		<td>Sanction Ref no</td>
		<td><input type="text" name="txt_sanctionrefno" value=""></td>									
	</tr>
	<tr>
		<td>Sanction Date</td>
		 <td>
		 <input type="text" name="txt_sanctiondate" size="15"
							maxlength="15" 
							value=""
							onblur="checkDate(this);allowalwysOldDate(this,document.forms[0].txt_inwarddate.value);">
							 <a id="iddatepickerforsan" style="visibility: hidden; position: absolute;"  href="#"
							onClick="callCalender1('txt_sanctiondate')"
								onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0"></a></td>
		<td>Lodge Ref No</td>
		 <td> <input type="text" name="txt_lodgerefno"  value=""></td>
		<td>Lodge Date</td>
		 <td><input type="text" name="txt_lodgedate" size="15"
							maxlength="15" 
							value=""
							onblur="checkDate(this);allowalwysOldDate(this,document.forms[0].txt_inwarddate.value);">
							 <a id="iddatepickerforlodge" style="visibility: hidden; position: absolute;" href="#"
							onClick="callCalender1('txt_lodgedate')"
								onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0"></a></td>				
	</tr>
	<tr>
		
		<td>Dropped Reference No</td>
		 <td> <input type="text" name="txt_droppedrefno"   value=""></td>						        	
		 <td>Dropped Date</td>
				 <td><input type="text" name="txt_droppeddate" size="15"
									maxlength="15" 
									value=""
									onblur="checkDate(this);allowalwysOldDate(this,document.forms[0].txt_inwarddate.value);">
									 <a id="iddatepickerfordropped" style="visibility: hidden; position: absolute;" href="#"
									onClick="callCalender1('txt_droppeddate')"
										onMouseOver="window.status='Date Picker';return true;"
											onMouseOut="window.status='';return true;"
									title="Click to view calender" border=0><img
									src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
									border="0"></a></td>
		<td>Deferred Details</td>
		 <td> 
		 <textarea name="txt_deferreddetails" onKeyDown="return DisableCopyPastealert(event)" onkeypress="return specialcharalert(event)" maxlength="3999"  cols="46" rows="2"></textarea></td>
		</td>
										
	</tr>		
	<tr>		
		<td>Deferred Date</td>
		 <td>						        	
		<input type="text" name="txt_deferreddate" size="15"
							maxlength="15" 
							value=""
							onBlur="checkDate(this);futureDate(this);">
							 <a href="#"
							onClick="callCalender1('txt_deferreddate')"
								onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
		border="0"></a>
		<td>
		Active
		</td>
		 <td width="10%"> <select name="activity_flagin_proposal">
								          <option value="0" selected="selected">&lt;---Select---&gt;</option>
								          <option value="Y">Yes</option>
								          <option value="N">No</option>
								        </select></td>
	</tr>				
</table>

</td>
</tr>

<!-- Button Portion in table -->
<tr>
<td>
		<table width="12%" border="0" cellspacing="0" cellpadding="0"	align="center" class="outertable">
			<tr>
				<lapschoice:combuttonnew btnnames='Edit_Save_Cancel' btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />	
			</tr>
		</table>
		
</td>
</tr>
<table class="outertable linebor" width="100%" border="0" cellspacing="0" cellpadding="3">
	<tr align="center">
		<td class="tabactivenew" width="2%">&nbsp;</td>
		<td class="tabactivenew" width="5%"><b>Inward Ref No</b></td>
		<td class="tabactivenew" width="5%"><b>Inward Date</b></td>
		<td class="tabactivenew" width="10%"><b>Branch Name</b></td>
		<td class="tabactivenew" width="5%"><b>Cust ID</b></td>
		<td class="tabactivenew" width="10%"><b>Borrower Name</b></td>
		<td class="tabactivenew" width="5%"><b>Status of Proposal</b></td>	
		<td class="tabactivenew" width="5%"><b>Exposure bracket</b></td>
		<td class="tabactivenew" width="10%"><b>Loan Process officer Id - Name</b></td>		
		<td class="tabactivenew" width="5%"><b>Due date for WC</b></td>
		<td class="tabactivenew" width="5%"><b>Proposed FB Limit (Rs. in Cr)</b></td>
		<td class="tabactivenew" width="5%"><b>Proposed NFB Limit (Rs. in Cr)</b></td>
		<td class="tabactivenew" width="5%"><b>Total Exposure(Rs in Cr)</b></td>
	</tr>
	<%if (arrRow != null && arrRow.size() > 0) {
				for (int i = 0; i < arrRow.size(); i++) {
					arrCol = (ArrayList) arrRow.get(i);

					%>
	<tr bgcolor="#EAE4DB" valign="top">
		<td width="2%"><input type="radio" name="rdosec"
			onclick="palceValues('<%=Helper.correctNull((String)arrCol.get(0))%>',
			'<%=Helper.correctNull((String)arrCol.get(1))%>','<%=Helper.correctNull((String)arrCol.get(2))%>',
			'<%=Helper.correctNull((String)arrCol.get(3))%>',
			'<%=Helper.correctNull((String)arrCol.get(4))%>','<%=Helper.correctNull((String)arrCol.get(5))%>',
			'<%=Helper.correctNull((String)arrCol.get(6))%>', '<%=Helper.correctNull((String)arrCol.get(7))%>',
			'<%=Helper.correctNull((String)arrCol.get(8))%>', '<%=Helper.correctNull((String)arrCol.get(9))%>'
			,'<%=Helper.correctNull((String)arrCol.get(10))%>','<%=Helper.correctNull((String)arrCol.get(11))%>',
			'<%=Helper.correctNull((String)arrCol.get(12))%>','<%=Helper.correctNull((String)arrCol.get(13))%>',
			'<%=Helper.correctNull((String)arrCol.get(14))%>','<%=Helper.correctNull((String)arrCol.get(15))%>',
			'<%=Helper.correctNull((String)arrCol.get(16))%>','<%=Helper.correctNull((String)arrCol.get(17))%>',
			'<%=Helper.correctNull((String)arrCol.get(18))%>','<%=Helper.correctNull((String)arrCol.get(19))%>',
			'<%=Helper.correctNull((String)arrCol.get(20))%>','<%=Helper.correctNull((String)arrCol.get(21))%>',
			'<%=Helper.correctNull((String)arrCol.get(22))%>','<%=Helper.correctNull((String)arrCol.get(23))%>',
			'<%=Helper.correctNull((String)arrCol.get(24))%>','<%=Helper.correctNull((String)arrCol.get(25))%>',
			'<%=Helper.correctNull((String)arrCol.get(26))%>','<%=Helper.correctNull((String)arrCol.get(27))%>','<%=Helper.correctNull((String)arrCol.get(28))%>')"
			style="border: none">
		</td>
		 <td width="5%" align="center"><%=Helper.correctNull((String)arrCol.get(0))%></td>
         <td width="5%" align="center"><%=Helper.correctNull((String)arrCol.get(1))%></td>
         <td width="10%" align="center"><%=Helper.correctNull((String)arrCol.get(4))%></td>
	     <td width="5%" align="center"><%=Helper.correctNull((String)arrCol.get(6))%></td>
	     <td width="10%" align="center"><%=Helper.correctNull((String)arrCol.get(7))%></td>
	     <%if(Helper.correctNull((String)arrCol.get(14)).equalsIgnoreCase("1")){ %>
	     <td  width="5%"  align="center">Query yet to be raised</td>
	     	<%} else if(Helper.correctNull((String)arrCol.get(14)).equalsIgnoreCase("2")){ %>
	     	<td  width="5%"  align="center">Reply yet to be received</td>
	     	<%} else if(Helper.correctNull((String)arrCol.get(14)).equalsIgnoreCase("3")){ %>
	     	<td  width="5%"  align="center">Under circulation</td>
	     	<%} else if(Helper.correctNull((String)arrCol.get(14)).equalsIgnoreCase("4")){ %>
	     	<td  width="5%"  align="center">Partial reply received</td>
	     	<%} else if(Helper.correctNull((String)arrCol.get(14)).equalsIgnoreCase("5")){ %>
	     	<td  width="5%"  align="center">Under Process</td>
	     	<%} else if(Helper.correctNull((String)arrCol.get(14)).equalsIgnoreCase("6")){ %>
	     	<td  width="5%"  align="center">Sanctioned</td>
	     	<%} else if(Helper.correctNull((String)arrCol.get(14)).equalsIgnoreCase("7")){ %>
	     	<td  width="5%"  align="center">Lodged</td>
	     	<%} else if(Helper.correctNull((String)arrCol.get(14)).equalsIgnoreCase("8")){ %>
	     	<td  width="5%"  align="center">Dropped</td>
	     	<%} %>
	     	
	     	 <%if(Helper.correctNull((String)arrCol.get(11)).equalsIgnoreCase("1")){ %>
		<td  width="5%"  align="center">Below 5 Cr</td>
		<%} else if(Helper.correctNull((String)arrCol.get(11)).equalsIgnoreCase("2")){ %>
	     	<td  width="5%"  align="center">5 - 15 Cr</td>
	     	<%} else if(Helper.correctNull((String)arrCol.get(11)).equalsIgnoreCase("3")){ %>
	     	<td  width="5%"  align="center">Above 15 Cr</td>
	     	<%} %>
		<td  width="10%"  align="center"><%=Helper.correctNull((String)arrCol.get(13))%></td>		
		<td  width="5%"  align="center"><%=Helper.correctNull((String)arrCol.get(18))%></td>
		<td  width="5%"  align="center"><%=Helper.correctNull((String)arrCol.get(8))%></td>
		<td width="5%"  align="center"><%=Helper.correctNull((String)arrCol.get(9))%></td>
		<td width="5%"  align="center"><%=Helper.correctNull((String)arrCol.get(10))%></td>
	</tr>
	<%}
			}

			%>
</table>

</table>
			
<lapschoice:hiddentag pageid="<%=PageId %>" /> 
<input type="hidden" name="exposurebracket">
<input type="hidden" name="hidUsername" value="<%=Helper.correctNull((String)session.getAttribute("strUserName"))%>"> 
<input type="hidden" name="hidOrgcode" value="<%=Helper.correctNull((String)session.getAttribute("strOrgCode"))%>">
</form>
</body>
</html>
