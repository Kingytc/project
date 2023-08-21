<%@include file="../share/directives.jsp"%>
<%request.setAttribute("_cache_refresh", "true");%>
<%ArrayList arryCol = null;
ArrayList arryRow = (ArrayList) hshValues.get("arryRow");%>


<html>
<head>
<title>Personal - Financial Investments</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/per/perfinancialinvst.js"> </script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varApptype="<%=Helper.correctNull((String) hshValues.get("strAppValue"))%>";	
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var hidtype="<%=Helper.correctNull((String)hshValues.get("hidtype"))%>";

function callOnload()
{
	if(document.forms[0].hidtype.value=="120001")
	{
		document.all.hid1.style.visibility="visible";	
			
	}
	else
	{
		document.all.hid1.style.visibility="hidden";		
		document.all.hid1.style.position="absolute";
	}
	if(document.forms[0].hidtype.value=="120002")
	{
		document.all.hid2.style.visibility="visible";
	}
	else
	{
		document.all.hid2.style.visibility="hidden";		
		document.all.hid2.style.position="absolute";
	}

	document.forms[0].txt_secdesc.readOnly=true;	
	document.forms[0].txt_secvalue.readOnly=true;	
	document.forms[0].txt_valuername.readOnly=true;	
	document.forms[0].txt_dateval.readOnly=true;
		
	document.forms[0].sel_securitytype.disabled=true;	
	document.forms[0].sel_securityclassifcation.disabled=true;	
	// document.forms[0].txt_proposed.readOnly=false;	
}

function checkColl()	
{
	document.all.ifrinvest.src = appURL+"action/iframefinancialinvst.jsp?hidBeanId=perfinancial&hidBeanGetMethod=getFinancialInvesmentCheck&hidid="+document.forms[0].txtstoc_desc.value;
}
function showSecurityAttach(varTextControl,varTextControl1,varHidControl,varHidControl1,varTextControl2,varHidControl2)
{
	if(document.forms[0].selapptype.value=="")
	{	alert("Please Select Applicant type");
	}
	else
	{
		var varQryString = "<%=ApplicationParams.getAppUrl()%>action/securitiesRetailAttach.jsp?hidcitycontrol="+varTextControl+"&hidstatecontrol="+varTextControl1+"&hidcitycodecontrol="+varHidControl+"&hidstatecodecontrol="+varHidControl1+"&hidzipcontrol="+varTextControl2+"&hidzipvaildatorcontrol="+varHidControl2;
		var title = "City";
		var prop = "scrollbars=yes,width=900,height=600,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}	
}
function callSecurityType() {
	
	
	var varSecurityType = document.forms[0].sel_securitytype.options[document.forms[0].sel_securitytype.selectedIndex].value;
	document.all.ifrmsecurityclassification.src = appURL
			+ "action/ifrmsecurityclassification.jsp?hidBeanGetMethod=getSecurityClassification&hidBeanId=securitymaster&securityclassificationtype="
			+ varSecurityType;

	}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
		  document.forms[0].elements[i].readOnly=val;		  
		}
		else if(document.forms[0].elements[i].type=="select-one")
		{
		  document.forms[0].elements[i].disabled=val;		  
		}
		
	}
}
function setValues(val1,val2,val3,val4,val5,val6)
{
	if(val3=="Farm Machinery")
	{
		document.forms[0].sel_securitytype.value="2";	
		document.forms[0].sel_securityclassifcation.value="2";	
	}
	else
	{
		document.forms[0].sel_securitytype.value="1";	
		document.forms[0].sel_securityclassifcation.value="1";	
	}
	document.forms[0].txt_secdesc.value=val3;	
	document.forms[0].txt_secvalue.value=val4;	
	document.forms[0].txt_valuername.value=val5;	
	document.forms[0].txt_dateval.value=val6;
	 
	document.forms[0].txt_secdesc.readOnly=true;	
	document.forms[0].txt_secvalue.readOnly=true;	
	document.forms[0].txt_valuername.readOnly=true;	
	document.forms[0].txt_dateval.readOnly=true;
	document.forms[0].sel_securitytype.disabled=true;	
	document.forms[0].sel_securityclassifcation.disabled=true;	
	
}
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callOnload()" >
<form name="finForm" action="" method="post" class="normal">
<jsp:include page="../share/Applurllinkper.jsp" flush="true">
<jsp:param name="pageid" value="3" />
</jsp:include>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Retail -&gt; Securities -&gt; Bank Deposits/ NSC/ KVP</td>
	</tr>
</table>
<lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="bottom">
		<table width="30%" border="0" cellspacing="1" cellpadding="3" class="outertable">
			<tr>			
				<td align="center" class="sub_tab_active" width="50%"><b>Securities</b></td>
				<!-- <td align="center" class="sub_tab_inactive" width="15%"><b><a href="JavaScript:callInsurancePolicy()" >Insurance Policies</a></b></td> -->
				<td align="center" class="sub_tab_inactive" width="50%"><b><a href="JavaScript:callLiabilities()" >Liabilities</a></b></td>
				<!-- <td align="center" class="sub_tab_inactive" width="15%"><b><a href="JavaScript:callLifeStyle()" >LifeStyle</a></b></td> -->
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td valign="middle">
								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
									<tr>
										<td>
										<table width="60%" border="0" cellspacing="3" cellpadding="3" align="center" class="outertable">
											<tr>
												
                                    <td align="right" width="25%"><a href="JavaScript:callApplicant()"> 
                                      </a>Applicant Type</td>
												
                                    <td width="28%">
<select name="selapptype" onChange="">
													<option value="">&lt;---- Select ----&gt;</option>
													<lapschoice:fincoappguarantor />
												</select></td>
                                    <td width="18%">
<input type="button" name="cmdAttach"	value="Attach" class="buttonStyle" style="width:75"
													onClick="showSecurityAttach()" tabindex="3"></td>
											 
                                  <td width="29%" >
<input type="button" name="cmdRemove" value="Remove" class="buttonStyle" style="width:75"
													onClick="" tabindex="3"></td> 
											</tr>
										</table>
										<table  width="20%" border="0" cellspacing="0" cellpadding="0" align="right" class="outertable">
											<tr>
									          
											</tr>
										</table>
										</td>
									</tr>
									<tr>
										<td valign="top">
										<tr>
								<td>
								<table width="95%" align="center" border="1" cellspacing="0" cellpadding="0" class="outertable" id="hid">
									<tr>
										<td>
										<table width="90%" border="0" cellpadding="10" cellspacing="0" class="outertable">
											<tr>
												
                  <td width="17%" height="37" > Security Type</td>
                  <td width="83%" height="37" > 
                    <select name="sel_securitytype"size="1"
							onChange="" tabindex="1">
							<option value="0">&lt;--Select--&gt;</option>
							<option value="1">Bank Deposit</option>
							<option value="2">Plant&Machinery</option>
                   
						</select></td>
												
											</tr>
											<tr>
												
                  <td width="17%" height="44" >Security Classification</td>
												
                  <td width="83%" height="44" > 
                   <select name="sel_securityclassifcation" size="1" tabindex="1">
                      <option selected value="0">--Select--</option>
                      <option value="1">Bank Deposits-FD</option>
							<option value="2">Irrigation Equipment</option>
                    </select></td>
												
											</tr>
											<tr>
												
                  <td width="17%" height="40">Security Description </td>
												
                  <td width="83%" height="40"> 
                    <input type="text" name="txt_secdesc"
													size="20" style="text-align:left" maxlength="30"
													onKeyPress=""></td>
												
											</tr>
											<tr>
												
                  <td width="17%" height="38">Net Security Value</td>
												
                  <td width="83%" height="38"> 
                    <input type="text" name="txt_secvalue" size="10" style="text-align:left" maxlength="20"
													onKeyPress="">
												</td>
												
											</tr>
											<tr>
												
                  <td width="17%" height="40">Valuer Name</td>
												
                  <td width="83%" height="40"> 
                    <input type="text" name="txt_valuername"
													size="20" style="text-align:left" maxlength="20"
													onKeyPress="">
                  </td>
											</tr>	
											<tr>
												
                  <td width="17%" height="46">Date of valuation</td>
												
                  <td width="83%" height="46"> 
                    <input type="text" name="txt_dateval"
													size="10" style="text-align:left" maxlength="20"
													onKeyPress="">&nbsp;<a alt="Select date from calender" href="#"
							onClick="callCalender('txt_dateval')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a>
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
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames="" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
				<td>

				<table width="95%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor" align="center">
					<tr class="dataheader">
						<td align="center">&nbsp;</td>
						<td align="center" valign="top">Security Id</td>
						<td align="center" valign="top">Security Type</td>
						<td align="center" valign="top">Security Classification</td>
						<td align="center" valign="top">Security Description</td>
						<td align="center" valign="top">Security value</td>
						<td align="center" valign="top">Type</td>
					</tr>
					
					<tr valign="top" class="datagrid" id="hid1">
						<td><input type="radio" name="selradio" style="border:none"
							onclick="setValues('Bank Deposit','Bank Deposits-FD','Fixed Deposit','50000.00','Rajesh','12/05/2013')"></td>
						<td align="center">120001</td>
						<td align="center">Bank Deposit</td>
						<td align="center">Bank Deposits-FD</td>
						<td align="center">Fixed Deposit</td>
						<td align="right">50000.00</td>
						<td align="center"><select name="seltype" disabled><option value="">Primary</option> </select></td>
						
					</tr>
					<tr valign="top" class="datagrid" id="hid2">
						<td><input type="radio" name="selradio1" style="border:none"
							onclick="setValues('Plant&Machinery','Irrigation Equipment','Farm Machinery','150000.00','Prakash','03/05/2013')"></td>
						<td align="center">120002</td>
						<td align="center">Plant&Machinery</td>
						<td align="center">Irrigation Equipment</td>
						<td align="center">Farm Machinery</td>
						<td align="right">150000.00</td>
						<td align="center"><select name="seltype1" disabled><option value="" >Collateral</option></td>
						
					</tr>
					
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

   <lapschoice:hiddentag pageid='<%=PageId%>'/> 
   <input type="hidden" name="cmdsave">
<INPUT TYPE="hidden" name="chostoc_applnt1"> 
<INPUT TYPE="hidden" name="hidsno"> 
<INPUT TYPE="hidden" name="radLoan" value="Y"> 
<INPUT TYPE="hidden" name="hidtype" value="<%=request.getParameter("hidtype") %>" > 
<iframe src="" id="ifrinvest" style="visibility:hidden"></iframe>
<iframe	height="0" width="0" id="ifrmsecurityclassification" frameborder=0 style="border: 0">

</form>
</body>
</html>


