<%@ include file="../share/directives.jsp"%>
<%String IncomeFlag = Helper.correctNull((String)session.getAttribute("IncomeFlag"));%>
<html>
<head>
<title>Setup(Products - Interest)</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/set/prdInterest.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<script language="JavaScript">
var val = "<%=request.getParameter("val")%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varpurpose="<%=Helper.correctNull((String) hshValues.get("purpose"))%>";
var prd_type="<%=Helper.correctNull((String) hshValues.get("prd_type"))%>";
var prd_loantype="<%=Helper.correctNull((String) hshValues.get("prd_loantype"))%>";
var prd_vehitype="<%=Helper.correctNull((String) hshValues.get("prd_vehitype"))%>";

function prdtype()
{
	document.all.pb1.style.visibility="hidden";
	document.all.pb1.style.position="absolute";
	document.all.pb2.style.visibility="hidden";
	document.all.pb2.style.position="absolute";
	
	if(prd_type=="pA")
	{
		document.all.pa.style.visibility="visible";
		document.all.pp1.style.visibility="hidden";
		document.all.pp2.style.visibility="hidden";
		document.all.pp3.style.visibility="hidden";	
		document.all.pp1.style.position="absolute";
		document.all.pp2.style.position="absolute";
		document.all.pp3.style.position="absolute";
		document.all.pp.style.visibility="hidden";
		document.all.pp.style.position="absolute";
		document.all.pp4.style.visibility="hidden";
		document.all.pp4.style.position="absolute";
		document.all.pa2.style.visibility="visible";
		document.all.pa2.style.position="relative";
		//document.all.Eduloan.style.display="none";
		document.all.Mortloan1.style.display="none";
		document.all.Mortloan2.style.display="none";
		//document.all.Salloan.style.display="none";
		document.all.pp6.style.visibility="hidden";
		document.all.pp6.style.position="absolute";
		document.all.pp7.style.visibility="hidden";
		document.all.pp7.style.position="absolute";
		document.all.pa1.style.visibility="visible";
		document.all.pa1.style.position="relative";
		//document.all.idcoapp1.style.visibility="hidden";
		//document.all.idcoapp1.style.position="absolute";
		
		document.all.pb1.style.visibility="visible";
		document.all.pb1.style.position="relative";
		document.all.pb2.style.visibility="visible";
		document.all.pb2.style.position="relative";
		
		if(varpurpose=="U" || varpurpose=="N")
		{
			document.all.idcoapp1.style.visibility="visible";
			document.all.idcoapp1.style.position="relative";

			document.all.row_soleprop.style.visibility="hidden";
			document.all.row_soleprop.style.position="absolute";

			document.all.row_coapp.style.visibility="hidden";
			document.all.row_coapp.style.position="absolute";
		}
		else
		{
			document.all.idcoapp1.style.visibility="hidden";
			document.all.idcoapp1.style.position="absolute";
		}

		
	}
	else if(prd_type=="pP")
	{
		document.all.pa.style.visibility="visible";
		document.all.pp1.style.visibility="visible";
		document.all.pp2.style.visibility="visible";
		document.all.pp3.style.visibility="visible";
		document.all.pp3.style.position="relative";
		document.all.pa.style.visibility="hidden";
		document.all.pa.style.position="absolute";
		document.all.pp.style.visibility="hidden";
		document.all.pp.style.position="absolute";
		document.all.pp4.style.visibility="hidden";
		document.all.pp4.style.position="absolute";
		document.all.pa2.style.visibility="visible";
		document.all.pa2.style.position="relative";
		//document.all.Eduloan.style.display="none";
		//document.all.Salloan.style.display="block";
		document.all.Mortloan1.style.display="none";
		document.all.Mortloan2.style.display="none";
		document.all.pp6.style.visibility="hidden";
		document.all.pp6.style.position="absolute";
		document.all.pp7.style.visibility="hidden";
		document.all.pp7.style.position="absolute";
		document.all.pa1.style.visibility="hidden";
		document.all.pa1.style.position="absolute";
		document.all.idcoapp1.style.visibility="hidden";
		document.all.idcoapp1.style.position="absolute";
	}
	else if(prd_type=="pH")
	{
		document.all.pp.style.visibility="visible";
		document.all.pp1.style.visibility="hidden";
		document.all.pp2.style.visibility="hidden";
		document.all.pp3.style.visibility="hidden";	
		document.all.pp1.style.position="absolute";
		document.all.pp2.style.position="absolute";
		document.all.pp3.style.position="absolute";
		document.all.pa.style.visibility="hidden";
		document.all.pa.style.position="absolute";

		
		if(varpurpose!="T")
		{
			document.all.pp4.style.visibility="visible";
			document.all.pp4.style.position="relative";
			document.all.idcoapp1.style.visibility="hidden";
			document.all.idcoapp1.style.position="absolute";
		}
		else
		{
			document.all.pp4.style.visibility="hidden";
			document.all.pp4.style.position="absolute";
			document.all.idcoapp1.style.visibility="visible";
			document.all.idcoapp1.style.position="relative";
		}

		if(varpurpose=="G"){
			document.all.idcoapp1.style.visibility="hidden";
			document.all.idcoapp1.style.position="absolute";
		}
		if(varpurpose=="C"){
			document.all.idcoapp1.style.visibility="hidden";
			document.all.idcoapp1.style.position="absolute";

			document.all.row_coapp.style.visibility="hidden";
			document.all.row_coapp.style.position="absolute";

			document.all.row_soleprop.style.visibility="hidden";
			document.all.row_soleprop.style.position="absolute";

			
			
		}
		document.all.pa2.style.visibility="hidden";
		document.all.pa2.style.position="absolute";
		//document.all.Eduloan.style.display="none";
		document.all.Mortloan1.style.display="none";
		document.all.Mortloan2.style.display="none";
		document.all.pp6.style.visibility="hidden";
		document.all.pp6.style.position="absolute";
		document.all.pp7.style.visibility="hidden";
		document.all.pp7.style.position="absolute";
		document.all.pa1.style.visibility="visible";
		document.all.pa1.style.position="relative";
		document.all.idageofvehicle.innerHTML="Maximum Age of the House";
		//document.all.Salloan.style.display="none";
		document.all.pb1.style.visibility="visible";
		document.all.pb1.style.position="relative";
		document.all.pb2.style.visibility="visible";
		document.all.pb2.style.position="relative";
	}
	else if(prd_type=="pM")
	{
		document.all.pp.style.visibility="hidden";
		document.all.pp.style.position="absolute";
		document.all.pp1.style.visibility="hidden";
		document.all.pp2.style.visibility="hidden";
		document.all.pp3.style.visibility="hidden";	
		document.all.pp1.style.position="absolute";
		document.all.pp2.style.position="absolute";
		document.all.pp3.style.position="absolute";
		document.all.pa.style.visibility="hidden";
		document.all.pa.style.position="absolute";
		document.all.pp4.style.visibility="visible";
		document.all.pp4.style.position="relative";
		document.all.pa2.style.visibility="hidden";
		document.all.pa2.style.position="absolute";
		//document.all.Eduloan.style.display="none";
		document.all.Mortloan1.style.display="table-row";
		document.all.Mortloan2.style.display="table-row";
		document.all.pp6.style.visibility="hidden";
		document.all.pp6.style.position="absolute";
		document.all.pp7.style.visibility="hidden";
		document.all.pp7.style.position="absolute";
		//document.all.Salloan.style.display="none";
		document.all.pa1.style.visibility="hidden";
		document.all.pa1.style.position="absolute";
		document.all.pb1.style.visibility="visible";
		document.all.pb1.style.position="relative";
		document.all.pb2.style.visibility="visible";
		document.all.pb2.style.position="relative";

		if(prd_loantype=="TL")
		{
			document.all.idcoapp1.style.visibility="visible";
			document.all.idcoapp1.style.position="relative";

			document.all.row_coapp.style.visibility="hidden";
			document.all.row_coapp.style.position="absolute";

			document.all.row_soleprop.style.visibility="hidden";
			document.all.row_soleprop.style.position="absolute";
		}
		else
		{
			document.all.idcoapp1.style.visibility="hidden";
			document.all.idcoapp1.style.position="absolute";
		}
	}
	else if(prd_type=="pE")
	{
		document.all.pp.style.visibility="hidden";
		document.all.pp.style.position="absolute";
		document.all.pp1.style.visibility="hidden";
		document.all.pp2.style.visibility="hidden";
		document.all.pp3.style.visibility="hidden";	
		document.all.pp1.style.position="absolute";
		document.all.pp2.style.position="absolute";
		document.all.pp3.style.position="absolute";
		document.all.pa.style.visibility="hidden";
		document.all.pa.style.position="absolute";
		document.all.pp4.style.visibility="hidden";
		document.all.pp4.style.position="absolute";
		document.all.pa2.style.visibility="hidden";
		document.all.pa2.style.position="absolute";
		//document.all.Eduloan.style.display="block";
		document.all.Mortloan1.style.display="none";
		document.all.Mortloan2.style.display="none";	
		document.all.pp5.style.visibility="hidden";
		document.all.pp5.style.position="absolute";
		document.all.pp6.style.visibility="visible";
		document.all.pp6.style.position="relative";
		document.all.pp7.style.visibility="hidden";
		document.all.pp7.style.position="absolute";	
		//document.all.Salloan.style.display="none";
		document.all.pa1.style.visibility="hidden";
		document.all.pa1.style.position="absolute";
		document.all.idcoapp1.style.visibility="hidden";
		document.all.idcoapp1.style.position="absolute";
	}
	else if(prd_type=="pL")
	{
		document.all.pp.style.visibility="hidden";
		document.all.pp.style.position="absolute";
		document.all.pp1.style.visibility="hidden";
		document.all.pp2.style.visibility="hidden";
		document.all.pp3.style.visibility="hidden";	
		document.all.pp1.style.position="absolute";
		document.all.pp2.style.position="absolute";
		document.all.pp3.style.position="absolute";
		document.all.pa.style.visibility="hidden";
		document.all.pa.style.position="absolute";
		document.all.pp4.style.visibility="hidden";
		document.all.pp4.style.position="absolute";
		document.all.pa2.style.visibility="hidden";
		document.all.pa2.style.position="absolute";
		//document.all.Eduloan.style.display="none";
		document.all.Mortloan1.style.display="table-row";
		document.all.Mortloan2.style.display="none";		
		document.all.pp5.style.visibility="hidden";
		document.all.pp5.style.position="absolute";
		document.all.pp6.style.visibility="hidden";
		document.all.pp6.style.position="absolute";
		document.all.pp7.style.visibility="visible";
		document.all.pp7.style.position="relative";
		//document.all.Salloan.style.display="none";
		document.all.pa1.style.visibility="hidden";
		document.all.pa1.style.position="absolute";
		document.all.idcoapp1.style.visibility="hidden";
		document.all.idcoapp1.style.position="absolute";
		document.all.pb1.style.visibility="visible";
		document.all.pb1.style.position="relative";
		document.all.pb2.style.visibility="visible";
		document.all.pb2.style.position="relative";
	}
	else if(prd_type=="pV")
	{
		document.all.pa.style.visibility="hidden";
		document.all.pp1.style.visibility="hidden";
		document.all.pp2.style.visibility="hidden";
		document.all.pp3.style.visibility="hidden";
		document.all.pp4.style.visibility="hidden";
		document.all.pp4.style.position="absolute";
		document.all.pa2.style.visibility="hidden";
		document.all.pa2.style.position="absolute";
		document.all.Mortloan1.style.display="none";
		document.all.Mortloan2.style.display="none";
		document.all.pp5.style.visibility="hidden";
		document.all.pp5.style.position="absolute";
		document.all.pp6.style.visibility="hidden";
		document.all.pp6.style.position="absolute";
		document.all.pp7.style.visibility="hidden";
		document.all.pp7.style.position="absolute";	
		document.all.pa1.style.visibility="hidden";
		document.all.pa1.style.position="absolute";
		document.all.idcoapp1.style.visibility="visible";
		document.all.idcoapp1.style.position="relative";
	}
	else if(prd_type=="pU")
	{
		document.all.pa.style.visibility="hidden";
		document.all.pp.style.position="absolute";
		document.all.pp1.style.visibility="hidden";
		document.all.pp2.style.visibility="hidden";
		document.all.pp3.style.visibility="hidden";	
		document.all.pp1.style.position="absolute";
		document.all.pp2.style.position="absolute";
		document.all.pp3.style.position="absolute";
		document.all.pp.style.visibility="hidden";
		document.all.pp.style.position="absolute";
		document.all.pp4.style.visibility="hidden";
		document.all.pp4.style.position="absolute";
		document.all.pa2.style.visibility="hidden";
		document.all.pa2.style.position="absolute";
		document.all.Mortloan1.style.display="none";
		document.all.Mortloan2.style.display="none";
		document.all.pp6.style.visibility="hidden";
		document.all.pp6.style.position="absolute";
		document.all.pp7.style.visibility="hidden";
		document.all.pp7.style.position="absolute";
		document.all.pa1.style.visibility="hidden";
		document.all.pa1.style.position="absolute";
		document.all.idcoapp1.style.visibility="hidden";
		document.all.idcoapp1.style.position="absolute";
	}
	else
	{
		document.all.pa.style.visibility="hidden";
		document.all.pp1.style.visibility="hidden";
		document.all.pp2.style.visibility="hidden";
		document.all.pp3.style.visibility="hidden";
		document.all.pp4.style.visibility="hidden";
		document.all.pp4.style.position="absolute";
		document.all.pa2.style.visibility="hidden";
		document.all.pa2.style.position="absolute";
		//document.all.Eduloan.style.display="none";
		document.all.Mortloan1.style.display="none";
		document.all.Mortloan2.style.display="none";
		document.all.pp5.style.visibility="hidden";
		document.all.pp5.style.position="absolute";
		document.all.pp6.style.visibility="hidden";
		document.all.pp6.style.position="absolute";
		document.all.pp7.style.visibility="hidden";
		document.all.pp7.style.position="absolute";	
		document.all.pa1.style.visibility="hidden";
		document.all.pa1.style.position="absolute";
		//document.all.Salloan.style.display="none";
		document.all.idcoapp1.style.visibility="hidden";
		document.all.idcoapp1.style.position="absolute";
	}
	if(prd_type=="pH" && varpurpose=="H")
	{
	document.all.pp.style.visibility="visible";
	document.all.pp.style.position="relative";
	document.all.pa1.style.visibility="visible";
	document.all.pa1.style.position="relative";
	document.all.idageofvehicle.innerHTML="Maximum Age of the House";
	}
	else if(prd_type=="pH" && varpurpose!="H")
	{
	document.all.pp.style.visibility="hidden";
	document.all.pp.style.position="absolute";
	document.all.pa1.style.visibility="hidden";
	document.all.pa1.style.position="absolute";
	}
	if(prd_type=="pA" && varpurpose=="U")
	{
	document.all.vehpur.style.visibility="visible";
	document.all.vehpur.style.position="relative";
	document.all.vehpur1.style.visibility="visible";
	document.all.vehpur1.style.position="relative";
	document.all.pa1.style.visibility="visible";
	document.all.pa1.style.position="relative";
	document.all.idageofvehicle.innerHTML="Maximum Age of the Vehicle";
	
	}
	else if(prd_type=="pA" && varpurpose!="U")
	{
	document.all.vehpur.style.visibility="hidden";
	document.all.vehpur.style.position="absolute";
	document.all.vehpur1.style.visibility="hidden";
	document.all.vehpur1.style.position="absolute";
	document.all.pa1.style.visibility="hidden";
	document.all.pa1.style.position="absolute";
	}
	else if(prd_type=="pU" && prd_vehitype=="2")
	{
	document.all.vehpur.style.visibility="hidden";
	document.all.vehpur.style.position="absolute";
	document.all.vehpur1.style.visibility="hidden";
	document.all.vehpur1.style.position="absolute";
	document.all.pa1.style.visibility="visible";
	document.all.pa1.style.position="relative";
	document.all.idageofvehicle.innerHTML="Maximum Age of the Vehicle";
	}
	else if(prd_type=="pB")
	{
	document.all.pb1.style.visibility="visible";
	document.all.pb1.style.position="relative";
	document.all.pb2.style.visibility="visible";
	document.all.pb2.style.position="relative";
	}


	
}

function opendisfixed(num,field)
{
	
	  var purl = appURL+"action/fixedselect.jsp?val=fixedselect&num="+num+"&prd_inttype="+field+"&identity=floating";
	  var prop = "scrollbars=no,width=450,height=360";	
	  var title = "InterestRate";
	  var xpos = (screen.width - 350) / 2;
	  var ypos = (screen.height - 320) / 2;
	  prop = prop + ",left="+xpos+",top="+ypos;
      window.open(purl,title,prop);
	
	
}

function checkAge()
{
	if(parseInt(trim(document.forms[0].prd_selfretireage.value)) >=  '100'){
		alert("Retirement Age (Self Employed) should be less than 100");
		document.forms[0].prd_selfretireage.value="";
		document.forms[0].prd_selfretireage.focus();
	}
}
function doSave()
{
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="setinterest";
	document.forms[0].hidBeanMethod.value="updateSpecificEligiblity";
	document.forms[0].hidBeanGetMethod.value="getSpecificEligiblity";
	document.forms[0].hidSourceUrl.value="/action/prodspeceligible.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();	
	
}
function doClose()
{	
	if( ConfirmMsg(100) )
	{
		document.forms[0].action=appUrl+"action/setsearchproducts.jsp";
		document.forms[0].hidBeanId.value="setsearchproducts";
		document.forms[0].hidBeanMethod.value="";
		document.forms[0].hidBeanGetMethod.value="";
		document.forms[0].submit();
	}
}
function callOtherTab1(url)
{
	if(!document.forms[0].cmdsave.disabled)
	{
		ShowAlert(103);
	}
	else
	{
		document.forms[0].hidBeanGetMethod.value="getSpecificEligiblity";
		document.forms[0].action=appUrl+"action/"+url;
		document.forms[0].submit();
	}
}

function doCancel()
{
	if(ConfirmMsg('102'))
	{
		document.forms[0].action=appUrl+"action/prodspeceligible.jsp";
		document.forms[0].hidBeanId.value="setinterest";
		document.forms[0].hidBeanGetMethod.value="getSpecificEligiblity";
		document.forms[0].submit();	
	}
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="callonload();loadUsedApp();prdtype()">
<form name="prdinterestfrm" method="post" action="<%=ApplicationParams.getAppUrl()%>controllerservlet" class="normal">  
<lapstab:setproductstab tabid="9" prdtype='<%=Helper.correctNull((String)request.getParameter("hidProductType"))%>'/>  
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
  <tr> 
    <td class="page_flow">Home -&gt; Setup -&gt; Retail &amp; Agriculture Products -&gt; Products -&gt; Repayment Capacity -&gt; Eligibility Parameters </td>
  </tr>
</table><br>
              <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" >
                <tr> 
                  <td> <fieldset> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                      <tr> 
                        <td> <lapschoice:products/> </td>
                      </tr>
                    </table>
                    </fieldset> 
                    </td>
                    </tr>
                    </table><br>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" >                    
                      <tr> 
                        <td> 
                          <table width="60%" border="0" cellspacing="1" cellpadding="3" class="outertable">
									<tr>
										<td align="center" class="sub_tab_inactive"><b><a href="JavaScript:callOtherTab('prodrepaycapacity.jsp')">Repayment Capacity</a></b></td>
										<td align="center" class="sub_tab_inactive"><a href="JavaScript:callOtherTab('prodCollateralSecurity.jsp')"><b>Collateral Security</b></a></td>
										<td align="center" class="sub_tab_inactive"><a href="JavaScript:callOtherTab('prodinterest.jsp')"><b>Eligibility Parameters</b></a></td>
										<td align="center" class="sub_tab_active"><b>Specific Eligibility Parameters</b></td>
									</tr>
							</table>
                        </td>
                      </tr>
                      </table>
     <table width="100%" border="0" align="center" cellspacing="0" cellpadding="0" class="outertable border1" >
		<tr><td>
                      <table width="90%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center" id="pp5">
                            <tr> 
                              <td>
                          <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
                            <tr id="pp"> 
                              <td colspan="3">Repayment period shall be restricted to (In case of purchase of House/Flat above 25yrs old)</td>
                              <td > 
                                <input type="text" name="prd_repayperiodhouse" size="5" onKeyPress="allowNumber(this)"  value="<%=Helper.correctNull((String)hshValues.get("prd_repayperiodhouse"))%>" onBlur="" maxlength="10" style="text-align:left" tabindex="1">
                                Years
                               </td>
                               
                              
                            </tr>  
                            <tr id="pp1"> 
                              <td>Collateral security not required up to Rs.</td>
                              <td colspan="">
                              <lapschoice:CurrencyTag name="prd_collateral"
									size="15" maxlength="10" 
									value='<%=Helper.correctNull((String)hshValues.get("prd_collateral"))%>'
									tabindex="18" /> 
                               </td>
                               <td> Minimum years in service</td>
                              <td> 
                                <input type="text" name="prd_minservice" size="8" 
                                value="<%=Helper.correctNull((String)hshValues.get("prd_minservice"))%>" 
                                onKeyPress="allowNumber(this)" onBlur="" maxlength="2" style="text-align:left" tabindex="2">
                                (For Non-Listed Companies)</td>
                              
                            </tr>   
                            <tr id="pa"> 
                              <td width="15%">Proof of own residence is mandatory<br>if the loan amount is above Rs.</td>
                              <td colspan=""> 
                                <input type="text" name="prd_proofownres" size="15" onKeyPress="allowNumber(this)"  value="<%=Helper.correctNull((String)hshValues.get("prd_proofownres"))%>" onBlur="" maxlength="10" style="text-align:left" tabindex="1">
                               </td>
                               <td width="15%" id="vehpur"> Loan Period should not exceed</td>
                              <td id="vehpur1"> 
                                <input type="text" name="prd_loanperiod" size="8" value="<%=Helper.correctNull((String)hshValues.get("prd_loanperiod"))%>" onKeyPress="allowNumber(this)" onBlur="" maxlength="4" style="text-align:left" tabindex="2">
                                (in month) from the date of registration for Old vehicle  loan</td>
                              
                            </tr>                          
                           
                            <tr id="pp2"> 
                            <td> Collateral Security % for  Liquid Securities</td>
                              <td> 
                                <input type="text" name="prd_liqsecurity" size="8" 
                                value="<%=Helper.correctNull((String)hshValues.get("prd_liqsecurity"))%>" 
                                onKeyPress="allowNumber(this)" onBlur="checkPercentage(this)" maxlength="4" style="text-align:left" tabindex="3">
                                
                                </td>
                              <td>Collateral Security % for other than Liquid Securities</td>
                              <td colspan="2"> 
                                <input type="text" name="prd_liqother" size="8" onKeyPress="allowNumber(this)"  
                                value="<%=Helper.correctNull((String)hshValues.get("prd_liqother"))%>" onBlur="checkPercentage(this)" 
                                maxlength="4" style="text-align:left" tabindex="4">
                                </td>
                              
                            </tr>
                   
                            <tr id="pp3">
                              <td width="28%">Minimum number of years the non listed company should deal with us</td>
                              <td colspan=""> 
                                <input type="text" name="prd_nonlist" size="8" onBlur=""
								value="<%=Helper.correctNull((String)hshValues.get("prd_nonlist"))%>" 
								maxlength="2"  tabindex="5"> </td>
                            </tr>
                            <tr id="pa2">
                            	<td>Loan period for Salaried should be</td>
								<td colspan="3">
								<input type="text" name="txtprd_loanperiod" size="8"
									value="<%=Helper.correctNull((String)hshValues.get("txtprd_loanperiod"))%>"   
									maxlength="2"   tabindex="6" onKeyPress="" onBlur="">  (in months) prior to the date of retirement
								</td>
                            </tr>
                            
                            <tr id="pa1">
                            	<td  colspan="3"> <span id="idageofvehicle">Maximum Age of the vehicle</span></td>
								<td>
								<input type="text" name="txt_maxageveh" size="8"
									value="<%=Helper.correctNull((String)hshValues.get("txt_maxageveh"))%>"   
									maxlength="2"   tabindex="6" onKeyPress="" onBlur="">  Years
								</td>
                            </tr>
                         
                            </table>
                        </td>
                      </tr>
                    </table>
                     <table width="90%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center" id="pp6">
                            <tr >
	                               <td width="28%">Cost % of Caution Deposit, Building Fund/Refundable deposit</td>
	                               <td><input type ="text" Name="txt_costcautiondep" onKeyPress="allowInteger();" style="text-align:right" maxlength="4" size="6" onBlur="checkPercentage(this)" value="<%=Helper.correctNull((String)hshValues.get("prd_CautionDeposit"))%>">
	                            </tr>
                            
	                            <tr >
			                            <td>Cost % of Book / Equipments /Computers/Other</td>
			                            <td><input type ="text" Name="txt_bookequip" onKeyPress="allowInteger();" style="text-align:right" maxlength="4" size="6" onBlur="checkPercentage(this)" value="<%=Helper.correctNull((String)hshValues.get("prd_bookequipments"))%>">
	                            </tr>
	                            <tr>
                              <td>Minimum percentage of Marks need to be obtain in Qualifying exam</td>
			                    <td><input type="text" name="prd_minmarks" size="4" onKeyPress="allowInteger();" onBlur="checkPercentage(this);"
                                value="<%=Helper.correctNull((String)hshValues.get("PRD_EXAMMINMARKS"))%>" maxlength="2" tabindex="7">
                                %
                               </td>
                            </tr>
	                </table>
	                       
	                        <table width=90%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center" id="pp7" >
                              <tr>
	                                     <td width="28%">Net Rent Receivable % </td>
	                                     <td><input type ="text" Name="txt_netrentreceivalble" onKeyPress="allowInteger();" style="text-align:right" maxlength="4" size="6" onBlur="checkPercentage(this)" value="<%=Helper.correctNull((String)hshValues.get("prd_leasenrReceivable"))%>">
                                         </td>
                                    </tr>
                                   
                                    <tr>
			                                <td>Times of Net Rent </td>
			                                <td><input type ="text" Name="txt_timesofnetrent" onKeyPress="allowInteger();" style="text-align:right" maxlength="8" size="6"  value="<%=Helper.correctNull((String)hshValues.get("prd_leasenrTimes"))%>">
		                                    </td>
                                    </tr>                             
                            </table>
                            
                             <table width=90%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
                             <tr id="pp4">
                              <td width="28%">Minimum number of years to be in Confirmed Service (Only for NRI)</td>
                              <td> 
                                <input type="text" name="prd_minconfservice" size="5" onKeyPress="allowInteger();" style="text-align:left"
                                value="<%=Helper.correctNull((String)hshValues.get("prd_minconfservice"))%>" maxlength="2" tabindex="7">
                                Years
                               </td>
                            </tr> 
                            
                             <tr id="Mortloan1">
                              <td>Percentage of Mortgage property for the loan amount</td>
                              <td>
                                <input type="text" name="txt_mortgageperc" size="5" onKeyPress="allowInteger();" 
                                value="<%=Helper.correctNull((String)hshValues.get("PRD_COLLATRALPERC"))%>" maxlength="3" tabindex="7">
                                %
                               </td>
                            </tr>
                            <tr id="Mortloan2">
                              <td>Income of applicants considered for assessments</td>
                              <td>
                                <input type="text" name="txt_noofapplicantsinc" size="5" onKeyPress="allowInteger();"
                                value="<%=Helper.correctNull((String)hshValues.get("PRD_NOOFAPPLICNTINC"))%>" maxlength="3" tabindex="7">
                                Members
                               </td>
                            </tr> 
                             
                            
                             </table> 
                             <table width=90%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center" id="idcoapp1">
                             <tr id="row_jointapp">
                              <td  width="28%">Maximum number of Joint Applicants</td>
                              <td> 
                                <input type="text" name="txt_maxnoofjointapplicant" size="5" onKeyPress="allowInteger();" style="text-align:left"
                                value="<%=Helper.correctInt((String)hshValues.get("prd_minnoofjointapp"))%>" maxlength="2" tabindex="7">
                                  Members
                               </td>
                            </tr> 
                             <tr id="row_coapp">
                              <td>Maximum number of  Co-Obligants/Guarantors</td>
                              <td>
                                <input type="text" name="txt_maxnoofguarantors" size="5" onKeyPress="allowInteger();" onBlur="checkPercentage(this);"
                                value="<%=Helper.correctInt((String)hshValues.get("prd_minnoofguarantors"))%>" maxlength="3" tabindex="7">
                                  Members
                               </td>
                            </tr>
                            <tr id="row_soleprop">
                              <td>Maximum number of Sole Properitier</td>
                              <td>
                                <input type="text" name="txt_maxnoofproperitier" size="5" onKeyPress="allowInteger();"
                                value="<%=Helper.correctInt((String)hshValues.get("prd_maxnoofproperitier"))%>" maxlength="3" tabindex="7">
                                Members
                               </td>
                            </tr> 
                            
                             </table> 
                           <table width=90%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">  
                             <tr id="pb1">
                            	<td width="28%">Minimum CIBIL Score</td>
								<td>
								<input type="text" name="txt_cibilscore" size="8"
									value="<%=Helper.correctNull((String)hshValues.get("prd_mincibilscore"))%>"   
									maxlength="3"  onKeyPress="allowInteger()" onBlur="">  
								</td>
                            </tr>
                            <tr id="pb2">
                            	<td>Maximum CRIF Score</td>
								<td>
								<input type="text" name="txt_crifscore" size="8"
									value="<%=Helper.correctNull((String)hshValues.get("prd_mincrifscore"))%>"   
									maxlength="3"  onKeyPress="allowInteger()" onBlur="">  
								</td>
                            </tr>
                            </table>
      </td></tr>
 </table>     
                            
<br>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
  <lapschoice:hiddentag pageid='<%=PageId%>'/>
  <input type=hidden name="hidSeldInsti" value="">
  <input type="hidden" name="checkApp" value="<%=request.getParameter("checkApp")%>">
  <input type="hidden" name="prd_code" value="<%=request.getParameter("prdCode")%>">
  <input type="hidden" name="prd_type" value="<%=request.getParameter("prd_type")%>">
  <input type="hidden" name="hidProductType" value="<%=Helper.correctNull((String)request.getParameter("hidProductType"))%>">
</form>
</body>
</html>
  




