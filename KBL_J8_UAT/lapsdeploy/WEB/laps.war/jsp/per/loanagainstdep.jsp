<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<html>
<lapschoice:handleerror />
<%ArrayList v = new ArrayList();
			String strcomid = Helper.correctNull((String) request	.getParameter("id1"));
			if (strcomid.equalsIgnoreCase("")) {
				strcomid = Helper.correctNull((String) hshValues.get("id1"));
			}
 String catgeryType=Helper.correctNull((String)request.getParameter("hidCategoryType")); 
			%>
<%if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}
			ArrayList g1 = new ArrayList();
			java.text.NumberFormat nf = java.text.NumberFormat
					.getNumberInstance();
			nf.setGroupingUsed(false);
			nf.setMaximumFractionDigits(2);
			nf.setMinimumFractionDigits(2);
String strEmployment=Helper.correctNull((String)hshValues.get("strEmployment"));
%>
<head>
<title>Loan Against Deposits</title>
<SCRIPT	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>	
<SCRIPT>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var strAction="<%=request.getParameter("hidAction")%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var currentdate = "<%=Helper.getCurrentDateTime()%>";
var varCustPullStatus="<%=Helper.correctNull((String)hshValues.get("strCustPullStatus"))%>";
var varOtherPullStatus="<%=Helper.correctNull((String)hshValues.get("strOtherPullStatus"))%>";
var varDocRecvdFrom="<%=Helper.correctNull((String)hshValues.get("strDocRecvdFrom"))%>";
var varAlert="<%=Helper.correctNull((String)hshValues.get("strAlert"))%>";
var vardeposittype="<%=Helper.correctNull((String)hshValues.get("prd_deposittype"))%>";
var vardepositloanfor="<%=Helper.correctNull((String)hshValues.get("prd_depositloanfor"))%>";
var varOtherDepFlag="<%=Helper.correctNull((String)hshValues.get("strOtherDepFlag"))%>";
function onloading()
{
	var varEmployment = "<%=strEmployment%>";
	if(varEmployment=="4")
	{
		document.forms[0].sel_banktype.options[2]=null;
	}
	clearfields();    
	disableFields(true);
	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
		if(varCustPullStatus=="YES")
		{
			disablePullingButtons(false,false,false,false,false);
			//disableCommandButtons("depdetpull");
		}
		else if(varOtherPullStatus=="YES")
		{
			disablePullingButtons(false,false,false,false,false);
		}
		else
		{
			//disableCommandButtons("load");
			disablePullingButtons(false,false,true,false,false);
		}
		if(varDocRecvdFrom=="1"||varDocRecvdFrom=="2"||varDocRecvdFrom=="3")
		{
			document.forms[0].cmdpullotherdepositdetails.disabled=true;
		}

		if((vardeposittype=="F" && vardepositloanfor=="T"))
		{
			document.forms[0].cmders.disabled=false;
			document.forms[0].cmdpullotherdepositdetails.disabled=false;
			document.forms[0].cmdpullcustomerdepositdetails.disabled=true;
		}
		else if((vardeposittype=="H") || (vardeposittype=="F" && vardepositloanfor=="O"))
		{
			document.forms[0].cmders.disabled=true;
			document.forms[0].cmdpullotherdepositdetails.disabled=true;
			document.forms[0].cmdpullcustomerdepositdetails.disabled=false;
		}
	}
	else
	{
		disablePullingButtons(true,true,true,true,true);
	}

	if(varOtherDepFlag=="Y")
	{
		alert("Third party securities are included in this proposal. Please select interest type in Loan Particulars tab to define Interest Rate");
	}
	if(varAlert != "" && appstatus == "Open/Pending")
	{
		alert(varAlert);
	}
}
function clearfields()
	{
	document.forms[0].hid_sno.value = "";  
    //document.forms[0].txtreceiptno.value = "";
    document.forms[0].txtissuseoffice.value = "";
    document.forms[0].txtaccountno.value = "";
    document.forms[0].txtstandname.value = "";
    document.forms[0].txt_issuedate.value ="";
    document.forms[0].txtfacevalue.value ="";
    document.forms[0].txt_rateofint.value ="";
    document.forms[0].txt_prsntos.value ="";    
    document.forms[0].txt_matval.value ="";
    document.forms[0].txtmatdate.value ="";
    document.forms[0].txtdeppercent.value ="";
    document.forms[0].txtmargin.value ="";
	}
function selectValues(val1, val2, val3, val4, val5,val6,val7,val8,val9,val10,val11,val12,val13,val14,val15,val16,val17)
{
	document.forms[0].hid_sno.value = val1;  
	//document.forms[0].txtreceiptno.value = val2;
	document.forms[0].txtissuseoffice.value = val2;	
	document.forms[0].txtstandname.value = val3;
	document.forms[0].txtaccountno.value = val4.value;
	document.forms[0].txt_issuedate.value = val5;
	document.forms[0].txtfacevalue.value = val6;
	document.forms[0].txt_rateofint.value =val7;	
	document.forms[0].txt_prsntos.value =val8;
	document.forms[0].txtpresentdate.value =val9;
	document.forms[0].txt_matval.value =val10;
	document.forms[0].txtmatdate.value =val12;
	document.forms[0].txtdeppercent.value =val13;
	document.forms[0].txtmargin.value =val14;
	document.forms[0].sel_banktype.value =val15;
	document.forms[0].hidSecurityId.value =val16;
	/*if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
		if(val17=="F")
		{
			disableCommandButtons("depdetpull");
		}
		else
		{
			disableCommandButtons("radioselect");
		}
	}*/
	//disablePullingButtons(true,true,true);
}
/*function doSave()
{
    if(document.forms[0].sel_banktype.value=="" )
	{
		 alert("Select Bank Type");
		 document.forms[0].sel_banktype.focus();
		 return;
	}
    if(document.forms[0].txtissuseoffice.value=="")
	{
		 alert("Enter Issuing Branch/ Post Office ");
		 document.forms[0].txtissuseoffice.focus();
		 return;
	}	
    if(document.forms[0].txtreceiptno.value=="" )
	{
		 alert("Enter Deposit/NSC Receipt No");
		 document.forms[0].txtreceiptno.focus();
		 return;
	}
	if(document.forms[0].txtstandname.value=="")
	{
		 alert("Enter Standing in the name of ");
		 document.forms[0].txtstandname.focus();
		 return;
	}	
	if(document.forms[0].txtaccountno.value=="")
	{
		 alert("Enter Account no");
		 document.forms[0].txtaccountno.focus();
		 return;
	}	
	if(document.forms[0].txt_issuedate.value=="")
	{
		 alert("Enter Date of issue");
		 document.forms[0].txt_issuedate.focus();
		 return;
	}	
	if(document.forms[0].txtmatdate.value=="")
	{
		 alert("Enter Maturity Date");
		 document.forms[0].txtmatdate.focus();
		 return;
	}	
	if(document.forms[0].txtfacevalue.value=="" || document.forms[0].txtfacevalue.value=="0.00")
	{
		 alert("Enter Face value");
		 document.forms[0].txtfacevalue.focus();
		 return;
	}	
	if(document.forms[0].txt_prsntos.value=="" || document.forms[0].txt_prsntos.value=="0.00")
	{
		 alert("Enter Present value ");
		 document.forms[0].txt_prsntos.focus();
		 return;
	}
	if(document.forms[0].txt_matval.value=="" || document.forms[0].txt_matval.value=="0.00")
	{
		 alert("Enter Maturity value");
		 document.forms[0].txt_matval.focus();
		 return;
	}	
	if(document.forms[0].txt_rateofint.value=="" || document.forms[0].txt_rateofint.value=="0")
	{
		 alert("Enter Rate of interest on Deposit %");
		 document.forms[0].txt_rateofint.focus();
		 return;
	}	
	var presentOutstanding =  document.forms[0].txt_prsntos.value;
	var faceValue =  document.forms[0].txtfacevalue.value;
	if(eval(presentOutstanding)<eval(faceValue))
	{
		alert("Present value should not be lesser than Face value");
		document.forms[0].txt_prsntos.focus();
		return;
	}
	var rateOfinterest =  document.forms[0].txt_rateofint.value;
	var rateOfinterestCharged =  document.forms[0].txtdeppercent.value;
	if(eval(rateOfinterestCharged)<eval(rateOfinterest))
	{
		alert("Rate of interest charged on loan/overdraft against deposit % should not be lesser than Rate of interest %");
		document.forms[0].txtdeppercent.focus();
		return;	
	}	
	var presentOutstanding =  document.forms[0].txt_prsntos.value;
	var maturityValue =  document.forms[0].txt_matval.value;
	if(eval(maturityValue)<eval(presentOutstanding))
	{
		alert("Maturity value should not be lesser than Face value and Present value amount");
		document.forms[0].txt_matval.focus();
		return;
	}	
	document.forms[0].hidBeanId.value="perpropertydetails";
	document.forms[0].hidSourceUrl.value="/action/loanagainstdep.jsp";
	document.forms[0].hidBeanMethod.value="updateLoanAgainstDep";
	document.forms[0].hidBeanGetMethod.value="getLoanAgainstDep";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();		
}*/
/*function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		//document.forms[0].cmdnew.disabled =false;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;		 
	}
	if(val=="edit")
	{	 
		 //document.forms[0].cmdnew.disabled =true;
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=true;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;
		 document.forms[0].cmdaudittrail.disabled=false;	 
		 disableFields(false);
	}
	if(val=="radioselect")
	{	 
		//document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=false;
		document.forms[0].cmdclose.disabled=true;
	}	  
	if(val=="depdetpull")
	{
		disableFields(true);
		//document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=true;
		document.forms[0].cmdaudittrail.disabled=true;
	}	  
}*/
/*function doEdit()
{ 
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	document.forms[0].hideditflag.value="Y";
	//disableCommandButtons('edit');
	disablePullingButtons(true,true,true);
}
function doNew()
{
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hideditflag.value="Y";
	disableFields(false);
	//disableCommandButtons("edit");
	clearfields();
	disablePullingButtons(true,true,true);
}
function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidBeanId.value="perpropertydetails";
		document.forms[0].hidBeanGetMethod.value="getLoanAgainstDep";
		document.forms[0].action=appURL+"action/loanagainstdep.jsp";
		document.forms[0].submit(); 		
	}
}*/
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
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=(!val);
		}	 
	}
	document.forms[0].txtdeppercent.readOnly=true;
}
/*function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appURL+"controllerservlet";
document.forms[0].hidSourceUrl.value="/action/loanagainstdep.jsp";
	document.forms[0].hidBeanMethod.value="updateLoanAgainstDep";
	document.forms[0].hidBeanGetMethod.value="getLoanAgainstDep";
		document.forms[0].hidBeanId.value="perpropertydetails";
		document.forms[0].method="post";			
		document.forms[0].submit();		
	 }	
}*/
function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/retailpge.jsp";
		document.forms[0].submit();
	}
}
function callCalender(fieldname)
{
	/*if(document.forms[0].hideditflag.value=="Y")
	{
		showCal(appURL,fieldname);
	}*/
}
function gototab(beanid,methodname,pagename)
{
	/*if(document.forms[0].cmdsave.disabled==true)
	{*/
		document.forms[0].hidBeanId.value=beanid;
		document.forms[0].hidBeanGetMethod.value=methodname;
		document.forms[0].action=appURL+"action/"+pagename;
		document.forms[0].submit();
	/*}
	else
	{
		ShowAlert('103');
	}*/
}
	function doRenewalDetails()
{
	var varQryString = <%=ApplicationParams.getAppUrl()%>+"action/per_renewal_details.jsp?appno="+document.forms[0].appno.value+"&hidBeanId=perpropertydetails&hidBeanGetMethod=getRenewalDetails";
	var title = "RenewalDetails";
	var prop = "status=yes,scrollbars=yes,width=750,height=460";	
	prop = prop + ",left=150,top=100";
	window.open(varQryString,title,prop);			
}
function doPullCustomerDepositDetails()
{
	var varQryString = <%=ApplicationParams.getAppUrl()%>+"action/perpullcustdeposit.jsp?txtsearch="+document.forms[0].hidCBSId.value;
	var title = "OtherDepositDetails";
	var prop = "status=yes,scrollbars=yes,width=750,height=460";	
	prop = prop + ",left=150,top=100";
	window.open(varQryString,title,prop);
}
function doErs()
{
	var varQryString = <%=ApplicationParams.getAppUrl()%>+"action/perpullotherdeposit.jsp?pagefrom=ers";
	var title = "OtherDepositDetails";
	var prop = "status=yes,scrollbars=yes,width=750,height=460";	
	prop = prop + ",left=150,top=100";
	window.open(varQryString,title,prop);
}
function doPullOtherDepositDetails()
{
	var varQryString = <%=ApplicationParams.getAppUrl()%>+"action/perpullotherdeposit.jsp?pagefrom=oth";
	var title = "OtherDepositDetails";
	var prop = "status=yes,scrollbars=yes,width=750,height=460";	
	prop = prop + ",left=150,top=100";
	window.open(varQryString,title,prop);
}

function doSecurityDescription()
{
	var varQryString = <%=ApplicationParams.getAppUrl()%>+"action/per_depsecuritydesc.jsp?hidBeanId=perpropertydetails&hidBeanGetMethod=getSecurityDesc";
	var title = "SecurityDescription";
	var prop = "status=yes,scrollbars=yes,width=800,height=460";	
	prop = prop + ",left=150,top=100";
	window.open(varQryString,title,prop);
}


function doUndo()
{
	if(ConfirmMsg('179'))
	{
		document.forms[0].hidAction.value ="undo";
		document.forms[0].hidBeanId.value="perpropertydetails";
		document.forms[0].hidBeanGetMethod.value="getLoanAgainstDep";
		document.forms[0].action=appURL+"action/loanagainstdep.jsp";
		document.forms[0].submit();
	}
}
function disablePullingButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdpullcustomerdepositdetails.disabled=bool1;
	document.forms[0].cmdpullotherdepositdetails.disabled=bool2;
	document.forms[0].cmdundo.disabled=bool3;
	document.forms[0].cmders.disabled=bool4;
	document.forms[0].cmdsecuritydescription.disabled=bool5;
}
function loadParent()
{
	document.forms[0].hidAction.value ="";
	document.forms[0].hidBeanId.value="perpropertydetails";
	document.forms[0].hidBeanGetMethod.value="getLoanAgainstDep";
	document.forms[0].action=appURL+"action/loanagainstdep.jsp";
	document.forms[0].submit();
}
function doRemove(sno,varsecid,varflag)
{
	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
		if(varflag=="F")
		{
			if(confirm("Do you think this deposit not required this time?"))
			{
				document.forms[0].hid_sno.value=sno;
				document.forms[0].hidSecurityId.value=varsecid;
				document.forms[0].hidAction.value ="delete";
				document.forms[0].hidBeanId.value="perpropertydetails";
				document.forms[0].hidBeanGetMethod.value="getLoanAgainstDep";
				document.forms[0].action=appURL+"action/loanagainstdep.jsp";
				document.forms[0].submit();
			}
		}
		else
		{
			alert("You cannot remove this deposit details");
		}
	}

}
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript1.2">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>
<form method="post" name="frmloanagainstdeposits" class="normal">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td><jsp:include page="../share/Applurllinkper.jsp">
			<jsp:param name="pageid" value="1" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<% if(catgeryType.equals("AGR"))
	      {  %>
		<td class="page_flow">Home -&gt;Agriculture -&gt; Loan Particulars -&gt; Loan Product</td>
		 <%}
		   else if(catgeryType.equals("LAD")){
		    %> <td class="page_flow">Home -&gt;Loan Against Gold Ornaments &amp; Deposits -&gt; Loan Particulars -&gt; Deposite Details</td>
		       <%} 
	       else{
	       %> <td class="page_flow">Home -&gt;Retail -&gt; Loan Particulars -&gt; Loan Product</td>
	       <%} %>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td><lapschoice:application /></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="bottom">
		<table width="93%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="left">
			<tr align="center">
				<td><jsp:include page="../per/applicanttab.jsp" flush="true">
					<jsp:param name="linkid" value="8" />
				</jsp:include></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td></td>
	</tr>
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="3" width="100%" class="outertable">
			<tr>
				<td>
				<table width="100%" border="1" cellspacing="0" cellpadding="3" class="outertable">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
							<tr>
								<td width="100%" align="center">
								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
											<tr>
												<td width="15%">Bank Type<span class="mantatory">&nbsp;*</span></td>
												<td width="16%">
													<select name="sel_banktype" style="width: 115">
														<option value="">--Select--</option>
														<option value="1">Our Bank</option>
														<option value="2">3rd Party</option>
													</select>
												</td>
												<td width="20%">Issuing branch/ post office<span class="mantatory">&nbsp;*</span></td>
												<td width="15%"><input type="text" name="txtissuseoffice"
													size="20" maxlength="25" value=""></td>

												<!--<td width="16%">Deposit/NSC receipt no<span class="mantatory">&nbsp;*</span></td>
												<td width="11%"><input type="text" name="txtreceiptno"
													size="20" style="text-align:left" maxlength="20" value="">
												</td>

												--><td width="21%">Deposit Owner Name<span class="mantatory">&nbsp;*</span></td>
												<td width="13%"><input type="text" name="txtstandname"
													size="20" style="text-align:left" maxlength="20"
													onKeyPress="textlimit(this,'400')" value=""></td>
											</tr>
											<tr>

												<td>Account no.<span class="mantatory">&nbsp;*</span></td>
												<td><input type="text" name="txtaccountno"
													size="20" style="text-align:left" maxlength="15" value="">
												</td>

												<td>Date of issue<span class="mantatory">&nbsp;*</span></td>
												<td nowrap="nowrap">
												<table border="0" cellspacing="0" cellpadding="0"
													width="15%">
													<tr>
														<td><input type="text" name="txt_issuedate" size="14"
															maxlength="10" tabindex="3" value=""
															onBlur="checkDate(this);checkmaxdate(this,currentdate);">&nbsp;
														</td>
														<td><a href="#" onClick="callCalender('txt_issuedate')"
															title="Click to view calender" border="0"><img
															src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
															width="0" border="0" tabindex="4"></a></td>
													</tr>
												</table>
												</td>
												<td>Maturity date<span class="mantatory">&nbsp;*</span></td>
												<td>
												<table border="0" cellspacing="0" cellpadding="0"
													width="30%">
													<tr>
														<td><input type="text" name="txtmatdate" size="14"
															maxlength="10" tabindex="3" value=""
															onBlur="checkDate(this);checkmindate(this,currentdate)">&nbsp;
														</td>
														<td><a href="#" onClick="callCalender('txtmatdate')"
															title="Click to view calender" border="0"> <img
															src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
															width="0" border="0" tabindex="4"></a></td>
													</tr>
												</table>
												</td>
											</tr>
											<tr>

												<td>Face value <b>(Rs)</b><span class="mantatory">&nbsp;*</span></td>
												<td><lapschoice:CurrencyTag name="txtfacevalue"
													size="20" maxlength="10" value='' />&nbsp;</td>

												<td>Present value <b>(Rs)</b><span class="mantatory">&nbsp;*</span></td>
												<td nowrap="nowrap"><input type="text" name="txt_prsntos"
													size="20"
													onKeyPress="allowNumber(document.forms[0].txt_prsntos)"
													style="text-align:right" maxlength="10" value=""></td>
												<td>Present Value as on<span class="mantatory">&nbsp;*</span></td>
												<td>
												<table border="0" cellspacing="0" cellpadding="0"
													width="30%">
													<tr>
														<td><input type="text" name="txtpresentdate" size="14"
															maxlength="10" value=""
															onBlur="checkDate(this);checkmindate(this,currentdate)">&nbsp;
														</td>
														<td><a href="#" onClick="callCalender('txtpresentdate')"
															title="Click to view calender" border="0"> <img
															src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
															width="0" border="0" tabindex="4"></a></td>
													</tr>
												</table>
												</td>
											</tr>
											<tr>
												<!--<td width="15%">Margin</td>
												<td width="19%"><input type="text" name="txtmargin"
													size="10" style="text-align:left"
													onBlur="checkPercentage(this)"
													onKeyPress="allowNumber(document.forms[0].txtmargin)"
													maxlength="5" value=""> %</td>
												-->
												<td>Maturity value <b>(Rs)</b><span class="mantatory">&nbsp;*</span></td>
												<td><lapschoice:CurrencyTag
													name="txt_matval" size="20" value='' maxlength="10" /></td>
												<td>Rate of interest on Deposit <b>(%)</b><span class="mantatory">&nbsp;*</span></td>
												<td><input type="text" name="txt_rateofint"
													size="5" onBlur="checkPercentage(this);"
													onKeyPress="allowNumber(document.forms[0].txt_rateofint)"
													style="text-align:left" maxlength="5" value=""></td>

												<td>ROI charged on loan against deposit <b>%</b></td>
												<td nowrap="nowrap"><input type="text"
													name="txtdeppercent" size="5"
													onBlur="checkPercentage(this);"
													onKeyPress="allowNumber(document.forms[0].txtdeppercent)"
													style="text-align:left" maxlength="5" value=""></td>
											</tr>
											<!--<tr>
												<td colspan="5">
														Note: For reduction in margin below 25% follow proper guidelines for approval as per delegation of loaning power.
												</td>
											</tr>-->
										</table>
										</td>
									</tr>
									<tr><td>&nbsp;</td></tr>
									<tr align="center">
										<td>
											<table width="12%" border="0" align="center" cellpadding="0" cellspacing="0" class="outertable">
											<tr>
												<td>
													<table width="0%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
													<tr>
														<td>
														<table width="0%" border="0" cellspacing="0" cellpadding="3">
														<tr valign="top">
															<td>
																<input type="button" name="cmdpullcustomerdepositdetails" class="buttonOthers"
																	value="Pull Customer Deposit Details" onClick="doPullCustomerDepositDetails();">
															</td>
															<td>
																<input type="button" name="cmders" class="buttonOthers"
																	value="Pull ERS/Proprietor/Minor Deposit Details" onClick="doErs();">
															</td>
															<td>
																<input type="button" name="cmdpullotherdepositdetails" class="buttonOthers"
																	value="Pull Other Deposit Details" onClick="doPullOtherDepositDetails();">
															</td>
															<td>
																<input type="button" name="cmdundo" class="buttonOthers"
																	value="Undo" onClick="doUndo();">
															</td>
															</tr>
														</table>
														</td>
													</tr>
													</table>
												</td>
											</tr>
											<tr>
												<td colspan="4"><lapschoice:combuttonnew btnnames='Security Description_Audit Trial'
													btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
												</td>
											</tr>
											</table>
										</td>
									</tr>
									<tr><td>&nbsp;</td></tr>
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
											
													<tr align="center" class="dataheader">
														<td width="3%"><b></b></td>
														<td width="5%"><b>Deposit Type</b></td>
														<td width="10%"><b>Issuing Branch Post Office </b></td>
														<td width="8%"><b>Account No</b></td>
														<td width="8%"><b>Deposit Owner Name</b></td>
														<td width="6%"><b>Date of Issue</b></td>
														<td width="8%"><b>Face Value(Rs.)</b></td>
														<td width="6%"><b>Rate of Interest %</b></td>
														<td width="8%"><b>Present O/S (Rs.)</b></td>
														<td width="7%"><b>Present O/S as on</b></td>
														<!--<td width="6%"><b>Margin %</b></td>-->
														<td width="8%"><b>Maturity Value (Rs.)</b></td>
														<td width="7%"><b>Maturity Date</b></td>
														<td width="10%"><b>Rate of Interest Charged on Loan / OverDraft against deposit %</b></td>
														<td width="4%">Remove&nbsp;</td>
													</tr>
												
										
												
													<%v = (ArrayList)hshValues.get("vecData");
			String inside = "N";
			if (v != null) {
				int vecsize = v.size();
				for (int l = 0; l < vecsize; l++) {
					inside = "Y";
					g1 = (ArrayList) v.get(l);%>
													<tr valign="top" class="datagrid">
														<td align="center"><input type="radio"
															style="border:none" name="radiobutton"
															value="<%=(Helper.correctNull((String)g1.get(3)))%>"
															onclick="javascript:selectValues('<%=Helper.correctNull((String)g1.get(0))%>',
															'<%=Helper.correctNull((String)g1.get(1))%>',
															'<%=Helper.correctNull((String)g1.get(2))%>',
															this,
															'<%=Helper.correctNull((String)g1.get(4))%>',
															'<%=Helper.checkDecimal(Helper.correctDouble((String)g1.get(5)))%>',
															'<%=Helper.checkDecimal(Helper.correctDouble((String)g1.get(6)))%>',
															'<%=Helper.checkDecimal(Helper.correctDouble((String)g1.get(7)))%>',
															'<%=Helper.correctNull((String)g1.get(8))%>',
															'<%=Helper.checkDecimal(Helper.correctDouble((String)g1.get(9)))%>',
															'<%=Helper.correctNull((String)g1.get(10))%>',
															'<%=Helper.correctNull((String)g1.get(11))%>',
															'<%=Helper.checkDecimal(Helper.correctDouble((String)g1.get(12)))%>',
															'<%=Helper.correctNull((String)g1.get(13))%>',
															'<%=Helper.correctNull((String)g1.get(14))%>',
															'<%=Helper.correctNull((String)g1.get(15))%>',
															'<%=Helper.correctNull((String)g1.get(16))%>')">
														</td>
														<%
															String strBankType=Helper.correctNull((String) g1.get(14));
															if(strBankType.equalsIgnoreCase("1"))
															{
																strBankType="Own";																
															}
															else if(strBankType.equalsIgnoreCase("2"))
															{
																strBankType="3rd Party";
															}
														%>
														<td align="center"><%=strBankType%></td>
														<td align="center" wrap="wrap"><%=Helper.correctNull((String) g1.get(1))%></td>
														<td align="center" valign="top" wrap="wrap"><%=Helper.correctNull((String)g1.get(3))%></td>
														<td align="center" wrap="wrap"><%=Helper.correctNull((String)g1.get(2))%></td>
														<td align="center" wrap="wrap"><%=Helper.correctNull((String)g1.get(4))%></td>
														<td align="right" wrap="wrap"><%=Helper.checkDecimal(Helper.correctDouble((String) g1.get(5)))%>&nbsp;</td>
														<td align="right" wrap="wrap"><%=Helper.checkDecimal(Helper.correctDouble((String) g1.get(6)))%>&nbsp;</td>
														<td align="right" wrap="wrap"><%=Helper.checkDecimal(Helper.correctDouble((String) g1.get(7)))%>&nbsp;</td>
														<td align="center" wrap="wrap"><%=Helper.correctNull((String)g1.get(8))%></td>
														<!-- <td align="right" wrap><%=Helper.correctNull((String) g1.get(13))%></td> -->
														<td align="right" wrap="wrap"><%=Helper.checkDecimal(Helper.correctDouble((String) g1.get(9)))%>&nbsp;</td>
														<td align="center" wrap="wrap"><%=Helper.correctNull((String) g1.get(11))%></td>
														<td align="right" wrap="wrap"><%=Helper.checkDecimal(Helper.correctDouble((String) g1.get(12)))%>&nbsp;</td>
														<td align="center"><img alt="Click to Delete Member" 
			src="<%=ApplicationParams.getAppUrl()%>img/delete.png" 
			onclick="doRemove('<%=Helper.correctNull((String)g1.get(0)) %>','<%=Helper.correctNull((String)g1.get(15))%>',
															'<%=Helper.correctNull((String)g1.get(16))%>')" style="cursor:hand"/>&nbsp;</td>
													</tr>
													<%}}%>
													<tr class="datagrid">
														<td align="center" >&nbsp;</td>
														<td wrap="wrap" align="center"></td>
														<td wrap="wrap" align="center" >&nbsp;</td>
														<td wrap="wrap" align="left" >&nbsp;</td>
														<td wrap="wrap" align="left" >&nbsp;</td>
														<td wrap="wrap" align="left" >&nbsp;</td>
														<td wrap="wrap" align="left" >&nbsp;</td>
														<td wrap="wrap" align="left" >&nbsp;</td>
														<td wrap="wrap" align="left" >&nbsp;</td>
														<td wrap="wrap" align="left" >&nbsp;</td>
														<td wrap="wrap" align="left" >&nbsp;</td>
														<td wrap="wrap" align="left" >&nbsp;</td>
														<td wrap="wrap" align="left" >&nbsp;</td>
														<td>&nbsp;</td>
														<!--<td wrap align="left" >&nbsp;</td>-->
													</tr>
													<%if (inside.equalsIgnoreCase("N")) {
													for(int i=0;i<1;i++){
													%>
													<tr class="datagrid">
														<td align="center" >&nbsp;</td>
														<td align="center"></td>
														<td align="center" >&nbsp;</td>
														<td align="left" >&nbsp;</td>
														<td align="left" >&nbsp;</td>
														<td align="left" >&nbsp;</td>
														<td align="left" >&nbsp;</td>
														<td align="left" >&nbsp;</td>
														<td align="left" >&nbsp;</td>
														<td align="left" >&nbsp;</td>
														<td align="left" >&nbsp;</td>
														<td align="left" >&nbsp;</td>
														<td align="left" >&nbsp;</td>
														<td>&nbsp;</td>
														<!--<td align="left" >&nbsp;</td>-->
													</tr>
													<%}}%>
										</table>
										</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
					</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>  <input type="hidden" name="hid_sno"
	value='<%=Helper.correctNull((String)hshValues.get("strid"))%>'> 
<input type="hidden" name="radLoan" value="Y">
<input type="hidden" name="txtmargin">
<input type="hidden" name="hidSecurityId" value="<%=Helper.correctNull((String) hshValues.get("strSecId"))%>">

<input type="hidden" name="hidCBSId" value="<%=Helper.correctNull((String) hshValues.get("strCBSId"))%>">
<input type="hidden" name="cmdsave" disabled="disabled">
</form>
</body>
</html>
