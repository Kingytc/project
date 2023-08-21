<%@include file="../share/directives.jsp"%>
<% 
	ArrayList arrList=null;
	arrList = (ArrayList) hshValues.get("arrRow");
%>
<html>
<head>
<title>NPA </title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/set/navigate.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>

<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var strGl="<%=Helper.correctNull((String) hshValues
    		.get("strGl"))%>";
var strExecSno="<%=Helper.correctNull((String)session.getAttribute("strExecSno"))%>";
var strExec_Date ="<%=Helper.correctNull((String)session.getAttribute("strExec_Date"))%>";
function checkexecdate(npadate){
	if(document.forms[0].txtNPADate.value !=""){
		
		var pgdt=changeDateformat(npadate.value);
		
		var maxdt=changeDateformat(document.forms[0].txt_executiondate.value);
		if(npadate.value!="" && document.forms[0].txt_executiondate.value!="" )
		{
			if(Date.parse(pgdt) > Date.parse(maxdt))
			{
				alert("NPA Date cannot be greater than MOC Date");
				document.forms[0].txtNPADate.value="";
				document.forms[0].txtNPADate.focus();
			}
		}
	}
}

function SelectValues(val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12,val13,val14,val15,val16,val17,val18,val19,val20,val21,val22,val23,val24,val25,val26,val27,val28,val29)
{
	if(val12=="P")
	{
		document.all.idprod.innerText="Product";
	}
	else
	{
		document.all.idprod.innerText="Facility";
	}
	document.all.idproddesc.style.color="#942188";
	document.forms[0].txtaccountno.value=val1;
	document.forms[0].txtproposalno.value=val2;
	document.forms[0].hidsno.value=val3;
	document.all.idproddesc.innerText=val4;
	document.forms[0].txtNPADate.value=val5;
	document.forms[0].txtoldNPADate.value=val5;
	document.forms[0].txtsancamt.value=val6;
	document.forms[0].txtoldsancamt.value=val6;
	document.forms[0].txtoutstandingamt.value=val7;
	document.forms[0].txtoldoutstandingamt.value=val7;
	document.forms[0].txtinterestval.value=val8;
	document.forms[0].txtoldinterestval.value=val8;
	document.forms[0].hidCBSID.value=val10;
	document.forms[0].txt_appname.value=val11;
	document.forms[0].txtLoantype.value=val13;
	document.forms[0].hidModule.value=val13;
	document.forms[0].txtexecutionno.value=val14;
	document.forms[0].txt_executiondate.value=val15;
	document.forms[0].txtorgsolid.value=val16;
	document.forms[0].txtorgname.value=val17;
	document.forms[0].txtclearbalance.value=val18;
	document.forms[0].txtoldclearbalance.value=val18;
	document.forms[0].txt_secvalue.value=val19;
	document.forms[0].txt_oldsecvalue.value=val19;
	document.forms[0].txt_provisionvalue.value=val20;
	document.forms[0].txt_oldprovisionvalue.value=val20;
	document.forms[0].sel_fraudapplicant.value=val21;
	document.forms[0].sel_oldfraudapplicant.value=val21;
	document.forms[0].sel_npanormstatus.value=val22;
	document.forms[0].sel_oldnpanormstatus.value=val22;
	document.forms[0].txt_regionname.value=val23;
	document.forms[0].txtmannualFlag.value=val24;
	document.forms[0].sel_writeoffflag.value=val25;
	document.forms[0].sel_oldwriteoffflag.value=val25;
	document.forms[0].txt_othercharges.value=val26;
	document.forms[0].txt_oldothercharges.value=val26;
	document.forms[0].txt_SBCA_Flag.value=val27;
	document.forms[0].txt_reason.value=val28;
	changeDesc('N');
	document.all.iddesc.style.display="table-cell";
	document.all.idproddesc.style.display="table-cell";
	if(val24=="Y")
	{
		document.forms[0].txtLoantype.className='';
		document.forms[0].txtproposalno.className='';
		document.forms[0].hidsno.className='';
		document.forms[0].txtaccountno.className='';
		document.forms[0].txtorgsolid.className='';
		document.forms[0].txtorgname.className='';
		document.forms[0].txt_regionname.className='';
		document.all.idsearch.style.display="inline";
		
	}
	else
	{
		document.forms[0].txtLoantype.className='finaclefieldsbgcolor';
		document.forms[0].txtproposalno.className='finaclefieldsbgcolor';
		document.forms[0].hidsno.className='finaclefieldsbgcolor';
		document.forms[0].txtaccountno.className='finaclefieldsbgcolor';
		document.forms[0].txtorgsolid.className='finaclefieldsbgcolor';
		document.forms[0].txtorgname.className='finaclefieldsbgcolor';
		document.forms[0].txt_regionname.className='finaclefieldsbgcolor';
		document.all.idsearch.style.display="none";
	
	}
	if(val29=="N"){
	  alert('Verification Pending. Complete the verification to proceed')	
	 callDisableControls(true,true,true,false,true,true);
	}else{
	 callDisableControls(false,true,false,false,true,true);
	}
}
function onLoad()
{
	document.all.iddesc.style.display="none";
	document.all.idproddesc.style.display="none";
	disablefields(true);
}
function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);
	}
}
function callDisableControls(cmdEdit,cmdSave,cmdCancel,cmdClose,cmdNew,cmdDelete)
{
	document.forms[0].cmdedit.disabled=cmdEdit;
	document.forms[0].cmdsave.disabled=cmdSave;
	document.forms[0].cmdcancel.disabled=cmdCancel;
	document.forms[0].cmdclose.disabled=cmdClose;
	document.forms[0].cmdnew.disabled=cmdNew;
	document.forms[0].cmddelete.disabled=cmdDelete;
}
function doEdit()
{
	document.forms[0].txtsancamt.readOnly=false;
	document.forms[0].txtoutstandingamt.readOnly=false;
	document.forms[0].txtinterestval.readOnly=false;
	document.forms[0].txt_secvalue.readOnly=false;
	document.forms[0].txt_provisionvalue.readOnly=false;
	document.forms[0].sel_fraudapplicant.disabled=false;
	document.forms[0].sel_npanormstatus.disabled=false;
	document.forms[0].sel_writeoffflag.disabled=false;
	document.forms[0].txt_othercharges.readOnly=false;
	callDisableControls(true,false,false,false,true,false);
	if(document.forms[0].txtmannualFlag.value=="Y")
	{
		document.forms[0].txtLoantype.disabled=false;
		document.forms[0].txtaccountno.readOnly=false;

		if(document.forms[0].txtLoantype.value!="S")
		{
			document.forms[0].txtproposalno.readOnly=false;
			document.forms[0].hidsno.readOnly=false;
		}
	}
}
function doSave()
{
	if(document.forms[0].txtmannualFlag.value=="Y")
	{
		if(document.forms[0].txtLoantype.value=="")
		{
			ShowAlert('111'," Loan Type");
			document.forms[0].txtLoantype.focus();
			return;
		}
		else if(document.forms[0].txtLoantype.value!="S")
		{
			if(document.forms[0].txtproposalno.value=="")
			{
				ShowAlert('121'," Proposal Number");
				document.forms[0].txtproposalno.focus();
				return;
			}
			else if(document.forms[0].hidsno.value=="")
			{
				ShowAlert('121'," Proposal Serial Number");
				document.forms[0].hidsno.focus();
				return;
			}
		}
		if(document.forms[0].txtLoantype.value=="S" && document.forms[0].txtaccountno.value=="")
		{
			ShowAlert('121'," SBCA Account Number");
			document.forms[0].txtaccountno.focus();
			return;
		}
		else if(document.forms[0].txtLoantype.value!="S" && document.forms[0].txtaccountno.value=="")
		{
			ShowAlert('121'," CBS Account Number");
			document.forms[0].txtaccountno.focus();
			return;
		}
		if(document.forms[0].txtorgsolid.value=="")
		{
			ShowAlert('121'," Organisation");
			return;
		}
	}
	if(document.forms[0].txtLoantype.value!="S")
	{
		if(document.forms[0].txtsancamt.value=="" ||document.forms[0].txtsancamt.value=="0.00")
		{
			ShowAlert('121'," Sanction Amount");
			document.forms[0].txtsancamt.focus();
			return;	
		}
		if(document.forms[0].txtoutstandingamt.value=="")
		{
			ShowAlert('121'," Outstanding Amount");
			document.forms[0].txtoutstandingamt.focus();
			return;	
		}
	}
	if(document.forms[0].txtinterestval.value=="")
	{
		ShowAlert('121'," Unrealized Interest value");
		document.forms[0].txtinterestval.focus();
		return;	
	}
	if(document.forms[0].txt_secvalue.value=="")
	{
		ShowAlert('121'," Security Value");
		document.forms[0].txt_secvalue.focus();
		return;	
	}
	if(document.forms[0].txtNPADate.value=="")
	{
		ShowAlert('111'," NPA Date");
		document.forms[0].txtNPADate.focus();
		return;	
	}
	if(document.forms[0].sel_fraudapplicant.value=="")
	{
		alert("Whether Fraud Applicant?");
		document.forms[0].sel_fraudapplicant.focus();
		return;	
	}
	if(document.forms[0].sel_npanormstatus.value=="")
	{
		ShowAlert('111'," NPA Norm Status");
		document.forms[0].sel_npanormstatus.focus();
		return;	
	}
	if(document.forms[0].txt_provisionvalue.value=="")
	{
		ShowAlert('121'," Provision Value");
		document.forms[0].txt_provisionvalue.focus();
		return;	
	}
	if(document.forms[0].sel_writeoffflag.value=="")
	{
		ShowAlert('111'," Write Off Flag");
		document.forms[0].sel_writeoffflag.focus();
		return;	
	}
	if(document.forms[0].txt_othercharges.value=="")
	{
		ShowAlert('121'," Other Charges Value");
		document.forms[0].txt_othercharges.focus();
		return;	
	}
	if(document.forms[0].txt_reason.value=="")
	{
		ShowAlert('121'," Reason for MOC");
		document.forms[0].txt_reason.focus();
		return;	
	}

	if(document.forms[0].txtsancamt.value!=document.forms[0].txtoldsancamt.value)
	{
		document.forms[0].txtinsertFlag.value="Y";
	}
	else if(document.forms[0].txtoutstandingamt.value!=document.forms[0].txtoldoutstandingamt.value)
	{
		document.forms[0].txtinsertFlag.value="Y";
	}
	else if(document.forms[0].txtinterestval.value!=document.forms[0].txtoldinterestval.value)
	{
		document.forms[0].txtinsertFlag.value="Y";
	}
	else if(document.forms[0].txt_secvalue.value!=document.forms[0].txt_oldsecvalue.value)
	{
		document.forms[0].txtinsertFlag.value="Y";
	}
	else if(document.forms[0].txtNPADate.value!=document.forms[0].txtoldNPADate.value)
	{
		document.forms[0].txtinsertFlag.value="Y";
	}
	else if(document.forms[0].sel_fraudapplicant.value!=document.forms[0].sel_oldfraudapplicant.value)
	{
		document.forms[0].txtinsertFlag.value="Y";
	}
	else if(document.forms[0].sel_npanormstatus.value!=document.forms[0].sel_oldnpanormstatus.value)
	{
		document.forms[0].txtinsertFlag.value="Y";
	}
	else if(document.forms[0].txt_provisionvalue.value!=document.forms[0].txt_oldprovisionvalue.value)
	{
		document.forms[0].txtinsertFlag.value="Y";
	}
	else if(document.forms[0].sel_writeoffflag.value!=document.forms[0].sel_oldwriteoffflag.value)
	{
		document.forms[0].txtinsertFlag.value="Y";
	}
	else if(document.forms[0].txt_othercharges.value!=document.forms[0].txt_oldothercharges.value)
	{
		document.forms[0].txtinsertFlag.value="Y";
	}
	disablefields(false);
	document.forms[0].hidBeanGetMethod.value="getNPAAccountDetails";
	document.forms[0].hidBeanId.value="borrowersearch";
	document.forms[0].hidBeanMethod.value="updateNPAAccountDetails";
	document.forms[0].hidSourceUrl.value="/action/npaaccountdetails.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanGetMethod.value="getNPAAccountDetails";
		document.forms[0].hidBeanId.value="borrowersearch";
		document.forms[0].action=appURL+"action/npaaccountdetails.jsp";	
		document.forms[0].submit();
	}
}
function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}
function disablefields(bool)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=bool;
		}
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=bool;
		}	  
	}
}
function calclearbalance()
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		if(NanNumber(parseFloat(document.forms[0].txtinterestval.value))>NanNumber(parseFloat(document.forms[0].txtoutstandingamt.value)))
		{
			alert("Unrealised Interest Value should not be greater than Outstanding Amount");
			document.forms[0].txtinterestval.value="";
			document.forms[0].txtclearbalance.value=NanNumber(parseFloat(document.forms[0].txtoutstandingamt.value))-NanNumber(parseFloat(document.forms[0].txtinterestval.value));
			document.forms[0].txtclearbalance.value=roundtxt(document.forms[0].txtclearbalance);
			document.forms[0].txtinterestval.focus();
			return;
		}
		else
		{
			document.forms[0].txtclearbalance.value=NanNumber(parseFloat(document.forms[0].txtoutstandingamt.value))-NanNumber(parseFloat(document.forms[0].txtinterestval.value));
			document.forms[0].txtclearbalance.value=roundtxt(document.forms[0].txtclearbalance);
		}
	}
}
function doNew()
{
	callDisableControls(true,false,false,true,true,true);
	document.forms[0].txtLoantype.className='';
	document.forms[0].txtproposalno.className='';
	document.forms[0].hidsno.className='';
	document.forms[0].txtaccountno.className='';
	document.forms[0].txtorgsolid.className='';
	document.forms[0].txtorgname.className='';
	document.forms[0].txt_regionname.className='';
	
	document.all.idsearch.style.display="inline";
	document.forms[0].txtmannualFlag.value="Y";
	document.forms[0].hidAction.value="insert";
	if(strGl=="Y"){
	varExeNo_gl="<%=Helper.correctNull((String)hshValues.get("strExeNo_gl"))%>";
	if(varExeNo_gl==""){
	   alert("No Records Found");
	   callDisableControls(true,true,true,false,true,true);
	   disablefields(true);
	   return;
	   
	}else{
	document.forms[0].txtexecutionno.value="<%=Helper.correctNull((String)hshValues.get("strExeNo_gl"))%>";
	document.forms[0].txt_executiondate.value="<%=Helper.correctNull((String)hshValues.get("strExeDate_gl"))%>";
	}
	}else{
		document.forms[0].txtexecutionno.value="<%=Helper.correctNull((String)hshValues.get("strExecSno"))%>";
		document.forms[0].txt_executiondate.value="<%=Helper.correctNull((String)hshValues.get("strExec_Date"))%>";
	}		 
	document.forms[0].txtsancamt.readOnly=false;
	document.forms[0].txtoutstandingamt.readOnly=false;
	document.forms[0].txtinterestval.readOnly=false;
	document.forms[0].txt_secvalue.readOnly=false;
	document.forms[0].txt_provisionvalue.readOnly=false;
	document.forms[0].sel_fraudapplicant.disabled=false;
	document.forms[0].sel_npanormstatus.disabled=false;
	document.forms[0].txtLoantype.disabled=false;
	document.forms[0].txtaccountno.readOnly=false;
	document.forms[0].sel_writeoffflag.disabled=false;
	document.forms[0].txt_othercharges.readOnly=false;
}
function changeDesc(varflag)
{
	if(document.forms[0].txtLoantype.value=="S")
	{
	  document.all.idcbsacc.innerText="SBCA Account  Number";
	}
	else
	{
		document.all.idcbsacc.innerText="CBS Account Number";
	}

	if(varflag && document.forms[0].txtLoantype.value!="S")
	{
		document.forms[0].txtproposalno.readOnly=false;
		document.forms[0].hidsno.readOnly=false;
	}
}
function showOrganizationSearch(path, forgscode, forgname)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		document.getElementById('txt_regionname').style.display="none";
		var varQryString = path+"action/searchOrg.jsp?forgscode="+forgscode+"&forgname="+forgname;
		var title = "Organization";
		var prop = "scrollbars=yes,width=500,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}
}
function doDelete()
{
	if(confirm("Do you want to Delete this Account information?"))
	{

		if(document.forms[0].txt_reason.value=="")
		{
			ShowAlert('121'," Reason for Modification");
			document.forms[0].txt_reason.focus();
			return;	
		}
		
		disablefields(false);
		document.forms[0].hidBeanGetMethod.value="getNPAAccountDetails";
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanId.value="borrowersearch";
		document.forms[0].hidBeanMethod.value="updateNPAAccountDetails";
		document.forms[0].hidSourceUrl.value="/action/npaaccountdetails.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}
function textlimit(field,maxlen)
{
	if(field.value.length>maxlen)
    {
		field.value=field.value.substring(0,maxlen);
		alert('Limit reached, your input has been truncated');
    }
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onLoad();">
<form method ="post" class="normal">
<br/>
<table width="90%" border="0" cellspacing="1" cellpadding="3" class="outertable border1" align="center">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center">
			<tr class="dataheader">
							<td colspan="6" align="center"> Customer Details</td>
						</tr>
			<tr>
			<td width="20%">Customer CBSID</td>
				<td width="15%"><input type="text"  name="hidCBSID" value="<%=Helper.correctNull((String)hshValues.get("strCBSID")) %>" class="finaclefieldsbgcolor" size="15">&nbsp;</td>
				<td width="15%">Customer Name</td>
				<td width="15%"  colspan="3"><input type="text" name="txt_appname" value="<%=Helper.correctNull((String)hshValues.get("strName")) %>" class="finaclefieldsbgcolor" size="45">&nbsp;</td>
			</tr>
			<tr class="dataheader">
					<td colspan="6" align="center"> Account Infomation</td>
				</tr>
				<tr>
					<td width="15%">Execution Number</td>
					<td width="15%"><input type="text" name="txtexecutionno" class="finaclefieldsbgcolor"></td>
					<td width="20%">Execution Date</td>
					<td width="15%"><input type="text" name="txt_executiondate"  class="finaclefieldsbgcolor"></td>
					<td width="15%">Loan type</td>
					<td width="15%"><select name="txtLoantype" class="finaclefieldsbgcolor" onchange="changeDesc('Y');">
						<option value=""><--select--></option>
						<option value="P">Retail</option>
						<option value="A">Agriculture</option>
						<option value="C">Corporate</option>
						<option value="S">SBCA </option>
						</select>&nbsp;</td>
				</tr>
				<tr>
					<td>Proposal Number</td>
					<td><input type="text" name="txtproposalno" id="txtproposalno" class="finaclefieldsbgcolor"></td>
					<td>Proposal S.No</td>
					<td><input type="text" name="hidsno" id="hidsno" class="finaclefieldsbgcolor"></td>
					<td id="iddesc"><span id="idprod">Facility</span>&nbsp; Description</td>
					<td><span id="idproddesc">&nbsp;</span><input type="hidden" name="hidModule"></td>
				</tr>
				<tr>
					<td width="15%"><span id="idcbsacc">CBS Account Number</span></td>
					<td width="15%"><input type="text" name="txtaccountno" id="txtaccountno" class="finaclefieldsbgcolor"></td>
					<td width="20%">Organisation</td>
					<td width="15%" colspan="3"><input type="text" name="txtorgsolid" id="txtorgsolid" class="finaclefieldsbgcolor" size="5">&nbsp;&nbsp;<input type="text" name="txtorgname" id="txtorgname" class="finaclefieldsbgcolor" size="35">&nbsp;&nbsp;<input type="text" name="txt_regionname" id="txt_regionname" class="finaclefieldsbgcolor" size="40">
					<span onClick="javascript:showOrganizationSearch('<%=ApplicationParams.getAppUrl()%>','txtorgsolid','txtorgname');" style="cursor: hand"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													id="idsearch" border="0" ></span>
					</td>
				</tr>
				
				<tr>
					<td><span style="float:left">Sanctioned Amount</span> <span style="float:right">Rs.</span></td>
					<td><input type="text" name="txtsancamt" style="text-align: right;" onblur="" onkeypress="allowNumber(this);">
					<input type="hidden" name="txtoldsancamt"></td>
					<td><span style="float:left">CBS Security Value</span> <span style="float:right">Rs.</span></td>
					<td><input type="text" name="txt_secvalue"  style="text-align: right;" onkeypress="allowNumber(this);"
						  onblur=""><input type="hidden" name="txt_oldsecvalue"></td>
					
					<td>NPA Date</td>
					<td><input type="text" name="txtNPADate" size="14" onBlur="checkDate(this);checkmaxdate(this,currentDate);checkexecdate(this);">
					&nbsp;<a alt="Select date from calender" href="#"
																	onClick="callCalender('txtNPADate')"
																	onMouseOver="window.status='Date Picker';return true;"
																	onMouseOut="window.status='';return true;"><img
																	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
																	border="0" alt="Select date from calender"></a>
																	<input type="hidden" name="txtoldNPADate">
					</td>
				</tr>
				
				<tr>
				<td width="20%"><span style="float:left">Outstanding Amount</span> <span style="float:right">Rs.</span></td>
					<td width="15%"><input type="text" name="txtoutstandingamt"  style="text-align: right;"  onkeypress="allowNumber(this);" 
					onblur="calclearbalance();"><input type="hidden" name="txtoldoutstandingamt"></td>
					<td><span style="float:left">Unrealized Interest Value</span> <span style="float:right">Rs.</span></td>
					<td><input type="text" name="txtinterestval"  style="text-align: right;" onkeypress="allowNumber(this);" 
						 onblur="calclearbalance();"><input type="hidden" name="txtoldinterestval"></td>
					<td><span style="float:left">Clear Balance Amount</span> <span style="float:right">Rs.</span></td>
					<td><input type="text" name="txtclearbalance"  style="text-align: right;" 
						 onblur="roundtxt(this);calclearbalance();"><input type="hidden" name="txtoldclearbalance"></td>
				</tr>
				<tr>
				<td>Write Off Flag</td>
				<td><select name="sel_writeoffflag">
						<option value=""><--select--></option>
						<option value="Y">Yes</option>
						<option value="N">No</option>
						</select>
						<input type="hidden" name="sel_oldwriteoffflag">
				</td>
				<td>Other Charges</td>
				<td><input type="text" name="txt_othercharges"  style="text-align: right;" onkeypress="allowNumber(this);"  
					onblur=""><input type="hidden" name="txt_oldothercharges"></td>
				</tr>
				<tr>
				<td>Fraud Applicant</td>
					<td>
						<select name="sel_fraudapplicant">
						<option value=""><--select--></option>
						<option value="Y">Yes</option>
						<option value="N">No</option>
						</select>
						<input type="hidden" name="sel_oldfraudapplicant">
					</td>
				<td>NPA Norm Status</td>
				<td>
					<select name="sel_npanormstatus">
						<option value=""><--select--></option>
						<option value="SS">SS</option>
						<option value="DS1">DS1</option>
						<option value="DS2">DS2</option>
						<option value="DS3">DS3</option>
						<option value="LOSS">LOSS</option>
						</select>
						<input type="hidden" name="sel_oldnpanormstatus">
				</td>
				<td><span style="float:left">Provision Value</span> <span style="float:right">Rs.</span></td>
					<td><input type="text" name="txt_provisionvalue"  style="text-align: right;" onkeypress="allowNumber(this);"  
					onblur=""><input type="hidden" name="txt_oldprovisionvalue"></td>
				</tr>
				<tr>
				<td>Reason for MOC&nbsp;</td>
				<td colspan="5"><textarea name="txt_reason"
													cols="90" rows="5"  onKeyPress="notAllowSingleAndDoubleQuote();checkEnter();textlimit(this,499)" onKeyUp="textlimit(this,499)"></textarea>&nbsp;</td>
				</tr>
				<tr><td colspan="6">&nbsp;</td></tr>
			</table>
		</td>
	</tr>
</table>

<table  width="95%" border="0" cellspacing="0" cellpadding="3" class="outertable"  align="center">
<tr><td>&nbsp;</td></tr>
<tr>
	<td>
		<lapschoice:combuttonnew
			btnnames='New_Edit_Save_Delete_Cancel'
			btnenable='Y' />
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
</table>

  <table width="90%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor"  align="center">   
   <%
   if( arrList!=null && arrList.size()>0)
   {%>
   
	  <tr class="dataheader" align="center">
	  <td width="3%">&nbsp;</td>
	   <td width="8%">Loan Type</td>
	  <td width="10%">Proposal No</td>
	  <td width="5%">S.No</td>
	   <td width="10%">CBS Account No</td>
	  <td width="10%">Sanction Amount</td>
	  <td width="10%">Outstanding</td>
	  <td width="10%">Clear Balance Amount</td>
	  <td width="10%">CBS security Value</td>
	  <td width="10%">Fraud Applicant</td>
	  <td width="10%">NPA Norm Status</td>
	  <td width="10%">Provision Value</td>
	  </tr> 
	   
	   <%int arrSize=arrList.size();	   
	   ArrayList  arrData=null;
	   for(int i=0;i<arrSize;i++)
		   {
		   		arrData=(ArrayList)arrList.get(i);%> 
		    	<tr class="datagrid"> 
		    	<td align="center"><input type="radio" name="radiobutton" onclick="SelectValues('<%=Helper.correctNull((String)arrData.get(0))%>','<%=Helper.correctNull((String)arrData.get(1))%>',
		    	'<%=Helper.correctNull((String)arrData.get(2))%>','<%=Helper.correctNull((String)arrData.get(3))%>',
		    	'<%=Helper.correctNull((String)arrData.get(4))%>','<%=Helper.correctNull((String)arrData.get(5))%>',
		    	'<%=Helper.correctNull((String)arrData.get(6))%>','<%=Helper.correctNull((String)arrData.get(7))%>',
		    	'<%=Helper.correctNull((String)arrData.get(8))%>','<%=Helper.correctNull((String)arrData.get(9))%>',
		    	'<%=Helper.correctNull((String)arrData.get(10))%>','<%=Helper.correctNull((String)arrData.get(11))%>'
		    	,'<%=Helper.correctNull((String)arrData.get(12))%>','<%=Helper.correctNull((String)arrData.get(13))%>'
		    	,'<%=Helper.correctNull((String)arrData.get(14))%>','<%=Helper.correctNull((String)arrData.get(15))%>'
		    	,'<%=Helper.correctNull((String)arrData.get(16))%>','<%=Helper.correctNull((String)arrData.get(17))%>'
		    	,'<%=Helper.correctNull((String)arrData.get(18))%>','<%=Helper.correctNull((String)arrData.get(19))%>'
		    	,'<%=Helper.correctNull((String)arrData.get(20))%>','<%=Helper.correctNull((String)arrData.get(21))%>'
		    	,'<%=Helper.correctNull((String)arrData.get(23))%>','<%=Helper.correctNull((String)arrData.get(24))%>'
		    	,'<%=Helper.correctNull((String)arrData.get(25))%>','<%=Helper.correctNull((String)arrData.get(26))%>'
		    	,'<%=Helper.correctNull((String)arrData.get(27))%>','<%=Helper.correctNull((String)arrData.get(28))%>','<%=Helper.correctNull((String)arrData.get(29))%>')" style="border: none;">&nbsp;</td>
      			<td align="center"><%=Helper.correctNull((String)arrData.get(11))%>&nbsp;</td>
      			<td align="center"><%=Helper.correctNull((String)arrData.get(1))%>&nbsp;</td>
      			<td align="center"><%=Helper.correctNull((String)arrData.get(2))%>&nbsp;</td>
      			<td><b><%=Helper.correctNull((String)arrData.get(0))%>&nbsp;</b></td>
      			<td align="right"><%=Helper.correctNull((String)arrData.get(5))%>&nbsp;</td>
      			<td align="right"><%=Helper.correctNull((String)arrData.get(6))%>&nbsp;</td>
      			<td align="right"><%=Helper.correctNull((String)arrData.get(17))%>&nbsp;</td>
      			<td align="right"><%=Helper.correctNull((String)arrData.get(18))%>&nbsp;</td>
      			<td align="center"><%=Helper.correctNull((String)arrData.get(22))%>&nbsp;</td>
      			<td align="center"><%=Helper.correctNull((String)arrData.get(21))%>&nbsp;</td>
      			<td align="right"><%=Helper.correctNull((String)arrData.get(19))%>&nbsp;</td>
       			</tr>
      <%}}%>
  </table>
  <br/><br/>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="txtinsertFlag">
<input type="hidden" name="txtmannualFlag">
<input type="hidden" name="txt_SBCA_Flag">
</form>
</body>
</html>
