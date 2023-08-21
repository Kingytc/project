<%@include file="../share/directives.jsp"%>
<% request.setAttribute("_cache_refresh", "true");%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var suit_decreed="<%=Helper.correctNull((String)hshValues.get("suit_decreed"))%>";
var suit_olappointed="<%=Helper.correctNull((String)hshValues.get("suit_olappointed"))%>";
var suit_courtname="<%=Helper.correctNull((String)hshValues.get("suit_courtname"))%>";
var terms_condts="<%//=Helper.correctNull((String)hshValues.get("terms_condts"))%>";


function showdetails()
{
	
	if(document.forms[0].sel_suitfiled.value=="1")
	{
		document.all.notable.style.visibility="hidden";
		document.all.notable.style.position="absolute";
		
		document.all.process1.style.visibility="hidden";
		document.all.process1.style.position="absolute";
		
		
		document.all.t1.style.visibility="visible";
		document.all.t1.style.position="relative";
		document.all.t2.style.visibility="visible";
		document.all.t2.style.position="relative";
		showAssets();
		document.forms[0].txt_noreason.value="";
		document.forms[0].txt_process.value="";
		
	}
	else if(document.forms[0].sel_suitfiled.value=="2")
	{
		document.all.notable.style.visibility="visible";
		document.all.notable.style.position="relative";
		
		document.all.process1.style.visibility="visible";
		document.all.process1.style.position="relative";
		
		document.all.t1.style.visibility="hidden";
		document.all.t1.style.position="absolute";
		document.all.t2.style.visibility="hidden";
		document.all.t2.style.position="relative";
		
	}
	else 
	{
		document.all.notable.style.visibility="hidden";
		document.all.notable.style.position="absolute";
		
		document.all.process1.style.visibility="hidden";
		document.all.process1.style.position="absolute";
		
		
		
		document.all.t1.style.visibility="hidden";
		document.all.t1.style.position="absolute";
		document.all.t2.style.visibility="hidden";
		document.all.t2.style.position="absolute";
		document.forms[0].sel_ol.value="0";
		
		document.forms[0].txt_noreason.value="";
		document.forms[0].txt_process.value="";
		
		showAssets();
		
	
		
		document.forms[0].txt_seccategoryadvance.value="";
		document.forms[0].txt_suitamount.value="";
		document.forms[0].txt_suitno.value="";
		document.forms[0].txt_suitdate.value="";
		document.forms[0].txt_runingledger.value="";
		document.forms[0].txt_dummyledger.value="";
		document.forms[0].txt_sec_advancedate.value="";
		document.forms[0].txt_premarketvalue.value="";
		document.forms[0].txt_premarketdate.value="";
		document.forms[0].txt_recoveryhalfyear.value="";
		document.forms[0].txt_totalrecovery.value="";
		document.forms[0].txt_dateofdecree.value="";
		document.forms[0].txt_dateofEP.value="";
		document.forms[0].txt_advocatename.value="";
		document.forms[0].txt_advocateaddress.value="";
		document.forms[0].txt_phoneno.value="";
		document.forms[0].txt_prepositionsuit.value="";
		document.forms[0].txt_staussaleofaddr.value="";
		document.forms[0].txt_facility.value="";
		document.forms[0].txt_lagalproceeding.value="";
		document.forms[0].txt_countrclaim.value="";
		document.forms[0].txt_compensation.value="";
		document.forms[0].txt_staliablity.value="";
		document.forms[0].txt_conliablity.value="";
		document.forms[0].txt_others.value=""; 
		document.forms[0].txt_pendingcriminal.value="";
		document.forms[0].txt_attachment.value="";
		document.forms[0].sel_ol.value="0";
		document.forms[0].sel_courtname.value="0";
		
	}
}
function showAssets()
{
	if(document.forms[0].sel_ol.value=="1")
	{
		document.all.t3.style.visibility="visible";
		document.all.t3.style.position="relative";
		document.all.t4.style.visibility="visible";
		document.all.t4.style.position="relative";
	}
	
	else 
	{
		document.all.t3.style.visibility="hidden";
		document.all.t3.style.position="absolute";
		document.all.t4.style.visibility="hidden";
		document.all.t4.style.position="absolute";
		document.forms[0].txt_staussaleofaddr.value="";
	}
}
function onLoading()
{
	if(suit_decreed=="1" || suit_decreed=="2")
	{
	  document.forms[0].sel_suitfiled.value=suit_decreed;	
	}
	else
	{
		document.forms[0].sel_suitfiled.value='0'
	}
	if(suit_olappointed=="1" || suit_olappointed=="2")
	{
	  document.forms[0].sel_ol.value=suit_olappointed;	
	}
	else
	{
		document.forms[0].sel_ol.value='0'
	}
	if(suit_courtname!=="")
	{
	  document.forms[0].sel_courtname.value=suit_courtname;	
	}
	else
	{
		document.forms[0].sel_courtname.value='0'
	}
	showdetails();
	disableFields(true);
}
function callsupnam()
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var prop = "scrollbars=no,width=500,height=400,top=100,left=250";
		var url=appUrl+"action/lawyermasterlist.jsp?hidBeanId=staticdata&hidBeanGetMethod=getLawyerMasterList&hidAction=search&strfrom=Status SuitFiled";
		window.open(url,"title",prop);
	}
	
}

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

function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	disableCommandButtons("edit");
	document.forms[0].sel_suitfiled.focus();	
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidmoduletype.value="STAT";
		document.forms[0].hidSourceUrl.value="/action/statusnote_suitfield.jsp";
		document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidBeanGetMethod.value="getstatusSuitfield";
		document.forms[0].hidBeanMethod.value="getstatusSuitfield";
		document.forms[0].action=appUrl +"controllerservlet";
		document.forms[0].submit(); 		
	}	
	
	disableCommandButtons("load");
}

function doSave()
	{
	if(document.forms[0].sel_suitfiled.value=="1")
	{
		if(document.forms[0].sel_courtname.value=="0")
		{
			alert("Select the Name of the court");
			document.forms[0].sel_courtname.focus();
			return;
		}
		if(document.forms[0].txt_suitno.value=="")
		{
			alert("Enter the Suit No.");
			document.forms[0].txt_suitno.focus();
			return;
		}
		if(document.forms[0].txt_totalrecovery.value=="")
		{
			alert("Enter Total Recovery till Date");
			document.forms[0].txt_totalrecovery.focus();
			return;
		}
		if(document.forms[0].txt_dateofdecree.value=="")
		{
			alert("Enter the Date of Decree");
			document.forms[0].txt_dateofdecree.focus();
			return;
		}
		if(document.forms[0].txt_decreeamount.value=="")
		{
			alert("Enter the Decree Amount");
			document.forms[0].txt_decreeamount.focus();
			return;
		}
		if(document.forms[0].txt_prepositionsuit.value=="")
		{
			alert("Enter the present position of suit");
			document.forms[0].txt_prepositionsuit.focus();
			return;
		}
		if(document.forms[0].sel_ol.value=="0")
		{
			alert("Select Whether OL Appointed");
			document.forms[0].sel_ol.focus();
			return;
		}
		if(document.forms[0].sel_ol.value=="1" && document.forms[0].txt_staussaleofaddr.value=="")
		{
			alert("Enter the Status of Sale of Asset");
			document.forms[0].txt_staussaleofaddr.focus();
			return;
		}		
	}
		document.forms[0].hidmoduletype.value="STAT";	
		document.forms[0].hidSourceUrl.value="/action/statusnote_suitfield.jsp";
		document.forms[0].hidAction.value ="insert";
		document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidBeanMethod.value="updatestatusSuitfield";
		document.forms[0].hidBeanGetMethod.value="getstatusSuitfield";
		document.forms[0].action=appUrl+"controllerservlet";
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
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=val;
		}	 
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].disabled=val;
		}
	
	}
	     document.forms[0].txt_suitdate.readOnly=true;
		document.forms[0].txt_premarketdate.readOnly=true;
		document.forms[0].txt_dateofdecree.readOnly=true;
	    document.forms[0].txt_dateofEP.readOnly=true;
		document.forms[0].txt_advocatename.readOnly=true;
		
	
}
function callCalender(fname)
{
if(document.forms[0].cmdsave.disabled==false)
	{
	 showCal(appUrl,fname);
	 }
}

function doDelete()
{
	if(ConfirmMsg(101))
		{	
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";		
		document.forms[0].hidBeanMethod.value="updatestatusSuitfield";
		document.forms[0].hidBeanGetMethod.value="getstatusSuitfield";
		document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidSourceUrl.value="action/statusnote_suitfield.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
		}
}
function doClose()
	{
	if(ConfirmMsg('100'))
		{
		document.forms[0].method="post";	
		document.forms[0].action=appUrl+"action/"+"npa_mainlinknav.jsp";
		document.forms[0].submit();
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
</script>
</head>

<body onload="onLoading()">

<form name="statusnotepage2" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
				<tr>
					<td>
						<lapstab:staturltag pageid="9"/>
					</td>
				</tr>
				<tr> 
           <td valign="top" class="page_flow">Home 
				-&gt; NPA-&gt; Status Note -&gt;Suit Filed Comments 
				</td>
          </tr>
			</table>
		</td>
	</tr>
</table>
<lapschoice:npaapplication />
<INPUT type="hidden" name="npa_appno" value="<%=(String)request.getParameter("npa_appno")%>" />
<table width="80%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable">
  <tr>
    <td width="37%" align="center">Whether suit filed/decreed?</td>
    <td width="63%">
      <select name="sel_suitfiled" onChange="showdetails()" tabindex="1">
        <option value="0">--select--</option>
        <option value="1">Yes</option>
        <option value="2">No</option>
      </select>
    </td>
  </tr>
  
  <tr id="process1">
  <td width="37%" align="center">Why not suit filed / decreed?</td>
      <td width="63%"> 
        <textarea rows="3" name="txt_noreason" cols="30" tabindex="17"
	 				onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("suit_noreason"))%></textarea>
      </td>
  </tr>
   <tr id="notable">
      <td width="37%" align="center">What under process etc should be appear. 
        For that one comment box should be provided</td>
      <td width="63%"> 
        <textarea rows="3" name="txt_process" cols="30" tabindex="17"
	 				onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("suit_process"))%></textarea>
      </td>
  </tr>
  
  </table>
  
  <table width="100%" border="0" cellspacing="1" cellpadding="3" id="t1" align="center" class="outertable">
    <tr> 
      <td width="15%">Sectoral Category of Advance</td>
      <td width="17%"> 
        <input type="text" name="txt_seccategoryadvance" maxlength="50" tabindex="2" value="<%=Helper.correctNull((String)hshValues.get("suit_sectoralcat"))%>">
      </td>
      <td width="16%">Amount of suit</td>
      <td width="17%"> 
        <lapschoice:CurrencyTag name="txt_suitamount" tabindex="3"
							maxlength="15" 
							value='<%=Helper.correctNull((String)hshValues.get("suit_amount"))%>' />
      </td>
      <td width="17%">Name of Court<span class="mantatory">*&nbsp;</span></td>
      <td width="18%"> 
        <select name="sel_courtname" tabindex="4">
          <option value="0">--select--</option>
          <option value="1">Civil</option>
          <option value="2">DRT</option>
          <option value="3">Revenue Recovery</option>
          <option value="4">High Court</option>
          <option value="5">Others</option>
        </select>
      </td>
    </tr>
    <tr> 
      <td width="15%">Suit No<span class="mantatory">*&nbsp;</span></td>
      <td width="17%"> 
        <input type"text" name="txt_suitno" tabindex="5"
							maxlength="20" onKeyPress="allowInteger()"
							value="<%=Helper.correctNull((String)hshValues.get("suit_no"))%>">
      </td>
      <td width="16%">Suit Date<span class="mantatory">*&nbsp;</span></td>
      <td width="17%"> 
        <input type="text" name="txt_suitdate" value="<%=Helper.correctNull((String)hshValues.get("suit_date"))%>" tabindex="6" onBlur="checkDate(this)">
        <a href="#" onClick="callCalender('txt_suitdate')"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0" tabindex="6"></a> </td>
      <td width="17%">Running Ledger O/s.</td>
      <td width="18%"> 
        <lapschoice:CurrencyTag name="txt_runingledger"
							maxlength="15"  tabindex="7"
							value='<%=Helper.correctNull((String)hshValues.get("siut_running"))%>' />
      </td>
    </tr>
    <tr> 
      <td width="15%">Dummy Ledger O/s.</td>
      <td width="17%"> 
        <lapschoice:CurrencyTag name="txt_dummyledger"
							maxlength="15"  tabindex="8"
							value='<%=Helper.correctNull((String)hshValues.get("siut_outstanding"))%>' />
      </td>
      <td width="16%">Value of Security on the date of advance</td>
      <td width="17%"> 
        <lapschoice:CurrencyTag name="txt_sec_advancedate" maxlength="15" tabindex="9"  value='<%=Helper.correctNull((String)hshValues.get("siut_securityvalueadvance"))%>' />
      </td>
      <td width="17%">Present Market Value</td>
      <td width="18%"> 
        <lapschoice:CurrencyTag name="txt_premarketvalue" maxlength="15" tabindex="10"  value='<%=Helper.correctNull((String)hshValues.get("siut_presentmarketvalue"))%>' />
      </td>
    </tr>
    <tr> 
      <td width="15%">Date of Valuation for present market value</td>
      <td width="17%"> 
        <input type="text" name="txt_premarketdate" tabindex="11" value="<%=Helper.correctNull((String)hshValues.get("suit_dateofvaluation"))%>" onBlur="checkDate(this)">
        <a href="#" title="Click to view calender" onClick="callCalender('txt_premarketdate')" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0" tabindex="11"></a> </td>
      <td width="16%">Recovery during the current half year</td>
      <td width="17%"> 
        <lapschoice:CurrencyTag name="txt_recoveryhalfyear" maxlength="15"  tabindex="12" value='<%=Helper.correctNull((String)hshValues.get("suit_recoveryhalf"))%>' />
      </td>
      <td width="17%">Total recovery till date<span class="mantatory">*&nbsp;</span></td>
      <td width="18%"> 
        <lapschoice:CurrencyTag name="txt_totalrecovery" maxlength="15" tabindex="13" value='<%=Helper.correctNull((String)hshValues.get("suit_totalrecovery"))%>' />
      </td>
    </tr>
    <tr> 
      <td width="15%">Date of Decree <span class="mantatory">*&nbsp;</span></td>
      <td width="17%"> <a href="#" onClick="callCalender('txt_suitdate')"
							title="Click to view calender" border=0> </a> 
        <input type="text" name="txt_dateofdecree" onBlur="checkDate(this)" value="<%=Helper.correctNull((String)hshValues.get("suit_dateofdecree"))%>" tabindex="14">
        <a href="#"
							title="Click to view calender" onClick="callCalender('txt_dateofdecree')"  border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0" tabindex="14"></a> </td>
							<td width="16%">Decree Amount<span class="mantatory">*&nbsp;</span></td>
      <td width="17%"><lapschoice:CurrencyTag name="txt_decreeamount" tabindex=""
							maxlength="15" 
							value='<%=Helper.correctNull((String)hshValues.get("decree_amount"))%>' /></td>
      
      <td width="16%">Date of filing EP</td>
      <td width="17%"> 
        <input type="text" name="txt_dateofEP" onBlur="checkDate(this)" tabindex="15" value="<%=Helper.correctNull((String)hshValues.get("suit_dateoffilling"))%>">
        <a href="#" onClick="callCalender('txt_dateofEP')"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0" tabindex="15"></a> </td>
      
    </tr>
    <tr> 
      <td width="15%">Name of Advocate/Address and</td>
      <td> 
        <input type="text" name="txt_advocatename"  tabindex="16" value="<%=Helper.correctNull((String)hshValues.get("suit_advocatename"))%>">
        <span onClick="javascript:callsupnam()"
											style="cursor:hand"><b><img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" tabindex="16"></b></span> 
      </td>
      <td>Address</td>
      <td> 
        <textarea rows="3" name="txt_advocateaddress" cols="30" 
	 				onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("suit_address"))%></textarea>
      </td>
      <td>Phone no.</td>
      <td> 
        <input type="text" name="txt_phoneno" maxlength="20"  onKeyPress="allowInteger()" value="<%=Helper.correctNull((String)hshValues.get("suit_phoneno"))%>">
      </td>
    </tr>
    <tr> 
      <td width="15%">Present position of suit<span class="mantatory">*&nbsp;</span></td>
      <td> 
        <textarea rows="3" name="txt_prepositionsuit" cols="30" tabindex="17"
	 				onKeyPress="textlimit(this,399)" onKeyUp="textlimit(this,399)"><%=Helper.correctNull((String) hshValues
							.get("suit_presentposition"))%></textarea>
      </td>
      <td>Whether OL appointed<span class="mantatory">*&nbsp;</span></td>
      <td> 
        <select name="sel_ol" onChange="showAssets()" tabindex="18">
          <option value="0">--select--</option>
          <option value="1">Yes</option>
          <option value="2">No</option>
        </select>
      </td>
      <td id="t3">Status of Sale of Assets<span class="mantatory">*&nbsp;</span></td>
      <td id="t4"> 
        <textarea rows="3" name="txt_staussaleofaddr" cols="30" tabindex="19"
	 				onKeyPress="textlimit(this,399)" onKeyUp="textlimit(this,399)"><%=Helper.correctNull((String) hshValues
							.get("suit_saleofstatus"))%></textarea>
      </td>
    </tr>
    
  </table>
  <br>
  <table width="100%" border="0" cellspacing="1" cellpadding="3" id="t2" class="outertable">
    <tr> 
      <td width="18%">Facility </td>
      <td width="25%"> 
        <textarea rows="3" name="txt_facility" cols="30" tabindex="20"
	 				onKeyPress="textlimit(this,39)" onKeyUp="textlimit(this,39)"><%=Helper.correctNull((String) hshValues
							.get("suit_facility"))%></textarea>
      </td>
      <td width="27%">Details of legal proceedings by other secured creditors/unsecured 
        creditors/workers </td>
      <td width="30%"> 
        <textarea rows="3" name="txt_lagalproceeding" cols="30" tabindex="21"
	 				onKeyPress="textlimit(this,399)" onKeyUp="textlimit(this,399)"><%=Helper.correctNull((String) hshValues
							.get("suit_legalproceeding"))%></textarea>
      </td>
    </tr>
    <tr> 
      <td width="18%">Details of any counter claim ny the borrower </td>
      <td width="25%"> 
        <textarea rows="3" name="txt_countrclaim" cols="30" tabindex="22"
	 				onKeyPress="textlimit(this,399)" onKeyUp="textlimit(this,399)"><%=Helper.correctNull((String) hshValues
							.get("suit_counterclaim"))%></textarea>
      </td>
      <td width="27%">&nbsp; </td>
      <td width="30%">&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="4">Details of third party liability </td>
    </tr>
    <tr> 
      <td colspan="2">&nbsp;</td>
      <td colspan="2">&nbsp;</td>
    </tr>
    <tr> 
      <td width="18%">a.Worker's Compensation</td>
      <td width="25%"> 
        <textarea rows="3" name="txt_compensation" cols="30" tabindex="23"
	 				onKeyPress="textlimit(this,300)"><%=Helper.correctNull((String) hshValues
							.get("suit_workercompensation"))%></textarea>
      </td>
      <td width="27%">b. Statutory Liabilities</td>
      <td width="30%"> 
        <textarea rows="3" name="txt_staliablity" cols="30" tabindex="24"
	 				onKeyPress="textlimit(this,399)" onKeyUp="textlimit(this,399)"><%=Helper.correctNull((String) hshValues
							.get("suit_Statliabilities"))%></textarea>
      </td>
    </tr>
    <tr> 
      <td width="18%">c.Contingent Liabilities</td>
      <td width="25%"> 
        <textarea rows="3" name="txt_conliablity" cols="30" tabindex="25"
	 				onKeyPress="textlimit(this,399)" onKeyUp="textlimit(this,399)"><%=Helper.correctNull((String) hshValues
							.get("suit_Contiliabilities"))%></textarea>
      </td>
      <td width="27%">d. Others</td>
      <td width="30%"> 
        <textarea rows="3" name="txt_others" cols="30" tabindex="26"
	 				onKeyPress="textlimit(this,399)" onKeyUp="textlimit(this,399)"><%=Helper.correctNull((String) hshValues
							.get("suit_Others"))%></textarea>
      </td>
    </tr>
    <tr> 
      <td width="18%">Details of pending criminal complaints</td>
      <td width="25%"> 
        <textarea rows="3" name="txt_pendingcriminal" cols="30" tabindex="27"
	 				onKeyPress="textlimit(this,399)" onKeyUp="textlimit(this,399)"><%=Helper.correctNull((String) hshValues
							.get("suit_pendingcriminal"))%></textarea>
      </td>
      <td width="27%">Any attachment/decree against any of the primary / collateral 
        security obtained by any of the authorities/lenders </td>
      <td width="30%"> 
        <textarea rows="3" name="txt_attachment" cols="30" tabindex="28"
	 				onKeyPress="textlimit(this,399)" onKeyUp="textlimit(this,399)"><%=Helper.correctNull((String) hshValues
							.get("suit_attachment"))%></textarea>
      </td>
    </tr>
  </table>


<br>
 <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<br>
 <lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hid_advocateid" value="<%=Helper.correctNull((String)hshValues.get("advocate_sno"))%>" />
<input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("AuditFlag"))%>">
</form>
</body>
</html>
