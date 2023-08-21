<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<laps:handleerror />
<%	String strProductType = Helper.correctNull((String) session.getAttribute("strProductType")).trim();
	if(strProductType.equalsIgnoreCase(""))
	{
		strProductType = Helper.correctNull((String)request.getParameter("hidAgrScheme"));
	}
	String prd_empretireage = Helper.correctNull((String) hshValues.get("prd_empretireage"));                                                                                                     
	String strrepayterm= Helper.correctNull((String)hshValues.get("prd_term"));
%>
<html>
<head>
<title>Setup(Products - Interest)</title>

<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/set/facInterest.js"></script>
<script language="JavaScript">
var scoringpattern="<%= Helper.correctNull((String)hshValues.get("scoringpattern"))%>";
var selperiod="<%=Helper.correctNull((String)hshValues.get("prd_inspection"))%>";
var coguincome="<%=Helper.correctNull((String)hshValues.get("prd_coguincome"))%>";
var strProductType = "<%=Helper.correctNull((String) hshValues.get("strProductType"))%>";
var strloantype= "<%=Helper.correctNull((String)hshValues.get("prd_typeofloan"))%>";
var varrepayterm="<%=Helper.correctNull((String)hshValues.get("prd_term"))%>";
var varrepayhol="<%=Helper.correctNull((String)hshValues.get("prd_repayhol"))%>";
var varsecuritytype="<%=Helper.correctNull((String)hshValues.get("prd_securitytype"))%>";
var strratingdesc="<%=Helper.correctNull((String)hshValues.get("prd_ratingdesc"))%>"
var val = "<%=request.getParameter("val")%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var vartablecode="<%=Helper.correctNull((String)hshValues.get("prd_tablecode"))%>";

<%
	int len = hshValues.size();
	out.println("var arrintr = new Array("+len+");");
	String keys[] = {"prd_inttype", "prd_intrate", "prd_addlint", "prd_totalint", "prd_collpass", "prd_liqpass",  "prd_collweight", "prd_liqweight", "prd_creditbureau","prd_procfees1","prd_procfees2","prd_docfees1","prd_docfees2","prd_inspection","prd_procfees","prd_docfees"};
	int i=0;
	while( i < keys.length )
	{
		if( hshValues.get(keys[i]) != null )
		{
			out.println("arrintr["+i+"] = '"+hshValues.get(keys[i])+"';");
		}
		i++;
	}
%>
function opendisfixed(num,field)
{
	if (document.forms[0].cmdedit.disabled == true)
	{
	  var purl = appUrl+"action/fixedselect.jsp?val=fixedselect&num="+num+"&prd_inttype="+field+"&identity=floating";
	  var prop = "scrollbars=no,width=450,height=360";	
	  var title = "InterestRate";
	  var xpos = (screen.width - 350) / 2;
	  var ypos = (screen.height - 320) / 2;
	  prop = prop + ",left="+xpos+",top="+ypos;
      window.open(purl,title,prop);
	}
	else
	{
	  alert("Click Edit/New To change");
	}
	
}
function changeLabel()
{
strProductType="<%=Helper.correctNull((String) session
					.getAttribute("strProductType"))%>";
if(strProductType=="pF")
{
if(document.forms[0].prd_furmargin.value !="")
{
document.forms[0].age_label1.value=document.forms[0].prd_furmargin.value;
}

}
}

function callRepayment()
{
	
	var varHoliday=document.forms[0].prd_holiday.value;
	if(varHoliday!="")
	{
	if(parseFloat(varHoliday)>=varrepayterm)
	  {
	 	 ShowAlert(153,"Holiday Period","Loan Period");
	  	 document.forms[0].prd_holiday.value="";
		 document.forms[0].prd_holiday.focus();
		 return;
	 }
	}
	
}
function callper()
{
 
if(document.forms[0].prd_margin.value >100)
   {
   alert("Percentage should not be greater than 100")
   document.forms[0].prd_margin.value=""; 
    document.forms[0].prd_margin.focus(); 
   }
 }
function callGovSecurities()
{
strProductType="<%=Helper.correctNull((String) session
					.getAttribute("strProductType"))%>";
if(strProductType=="pL")
{
var sel_securitytype=document.forms[0].sel_securitytype.value;
if(sel_securitytype=="GOV")
{
		document.all.idnew1.style.visibility="visible";
		document.all.idnew1.style.position="relative";
		document.all.prd_margin.style.visibility="visible";
		document.all.prd_margin.style.position="relative";

}
else
{
		document.all.idnew1.style.visibility="hidden";
		document.all.idnew1.style.position="absolute";
		document.all.prd_margin.style.visibility="hidden";
		document.all.prd_margin.style.position="absolute";
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


</script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="callonload();loadUsedApp();enableSpecialVidya();enableVehicle();callbusiness();callSpecialVidya();changeLabel();callGovSecurities();callVisibility()">
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

</script></div>
</div>
<form name="prdinterestfrm" method="post"
	action="<%=ApplicationParams.getAppUrl()%>controllerservlet">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top" colspan="5"><jsp:include page="../share/help.jsp"
					flush="true"/>
				 <jsp:include page="../share/menus.jsp" flush="true"/>
				></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
	<%if(Helper.correctNull((String)request.getParameter("fac_module")).equalsIgnoreCase("a")){%>
		<td class="page_flow">Home --&gt; Setup -&gt; Corporate &amp; Agri Products -&gt;Facility Creation -&gt; Agri Parameters -&gt; Eligibility Parameters</td>
	<%}else{%>
		<td class="page_flow">Home --&gt; Setup -&gt; Retail/Agriculture Products -&gt;Search Products -&gt; Agri Parameters -&gt; Eligibility Parameters</td>
	<%}%>
	</tr>
	<tr>
		<td align="right">
		<table width="100%" border="0" cellspacing="1" cellpadding="3"
			align="left">
	          <tr> 
            <td width="12%" align="center" class="darkTabColor"><a href="javascript:callOtherTab('setfacility.jsp')" class="darkTabColor">Facility</a></td>
            <td width="12%" align="center" class="darkTabColor"><a href="javascript:callOtherTab('setfacilityusedby.jsp')" class="darkTabColor">UsedBy</a></td>
            <td width="10%" align="center" class="darkTabColor"><a href="javascript:callOtherTab('setfacprocesscharges.jsp')" class="darkTabColor"> Charges </a></td>
            <td width="10%" align="center" class="darkTabColor"nowrap><a href="javascript:callOtherTab('setfacilitydelegation.jsp')" class="darkTabColor" > Delegated Powers </a></td>
            <td width="13%" align="center" class="darkTabColor"><a href="javascript:callOtherTab('setfacilityintterms.jsp')" class="darkTabColor">Int. &amp; Tenors</a></td>
            <td width="12%" align="center" class="darkTabColor"><a href="javascript:callOtherTab('otherdetails')" class="darkTabColor"> Other Details</a></td>
			<td width="12%" align="center" class="darkTabColor"><a href="javascript:callOtherTab('securitytype.jsp')" class="darkTabColor">Security</a></td>
			<td width="16%" align="center" class="darkTabColor"><a href="javascript:callOtherTab('set_rangedeviation.jsp')" class="darkTabColor">Range Deviation</a></td>
			
		<%if(Helper.correctNull(request.getParameter("fac_module")).trim().equalsIgnoreCase("a")) {%>
			<td width="16%" align="center" class="lightTabColor" nowrap="nowrap">Agri Parameters</td>
		<%} %>	
          </tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="5" align="center" class="shadow">
	<tr>
		<td valign="top">
		<table width="98%" border="0" cellspacing="0" cellpadding="5">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="3">
							<tr>
								<td><laps:facility /></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="1" cellpadding="3"
					align="left">
					<tr>
						<td width="" align="center" id="prm" class="lightTabColor">Eligibility Parameters</td>
						<td width="" align="center" id="com2" class="darkTabColor"><a
							href="JavaScript:callOtherTab('facMarginAmount.jsp')"
							class="darkTabColor"> Margin </a></td>
						<td width="" align="center" id="com2" class="darkTabColor"><a
							href="JavaScript:callOtherTab('facCollateralSecurity.jsp')"
							class="darkTabColor">Collateral Security</a></td>
						<td width="" align="center" class="darkTabColor" nowrap><a href="javascript:callOtherTab('setagriproperties.jsp')" class="darkTabColor"> Agri Properties</a></td>
						 <td width="" align="center" class="darkTabColor" nowrap><a href="javascript:callOtherTab('set_shgfacilitydose.jsp')" class="darkTabColor"> Eligible Limit</a></td>
						<td width="" align="center" class="darkTabColor" nowrap="nowrap"><a
							href="javascript:callOtherTab('setagrprdrytumitra.jsp')"
							class="darkTabColor"> Eligibility Conditions</a></td>
						 <td width="" align="center" class="darkTabColor"><a
							href="JavaScript:callOtherTab('setagrprdlanddevelopmenteligibility.jsp')"
							class="darkTabColor">Other Eligibility Conditions </a></td>
						 <td width="" align="center" class="darkTabColor" nowrap="nowrap"><a
							href="javascript:callOtherTab('setagrprdruralcreditcards.jsp')"
							class="darkTabColor"> Repayment Capacity</a></td>						
							<td width="" align="center" class="darkTabColor" nowrap="nowrap"><a
							href="javascript:callOtherTab('set_shgdose1.jsp')"
							class="darkTabColor"> Dose I</a></td>
						<td width="" align="center" class="darkTabColor" nowrap="nowrap"><a
						href="javascript:callOtherTab('setprdshgdose2.jsp')"
						class="darkTabColor"> Dose II</a></td>
						<td width="" align="center" class="darkTabColor" nowrap="nowrap"><a
							href="javascript:callOtherTab('setprdshgdose3.jsp')"
						class="darkTabColor"> Overall Eligible Limit</a></td>	
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="1"
					class="outertable border1">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="1" cellpadding="3">
                            <%if(strProductType.equalsIgnoreCase("pE") || strProductType.equalsIgnoreCase("p3")){ %>
                            <tr style="visibility:visible;position:relative">
                            	<td width="21%">Type of Loan<span class="mantatory">*</span></td>
                            	<td colspan="2" width="21%">
                            	
                            	<select name="prd_typeofloan" tabindex="1" onChange="enableSpecialVidya();callSpecialVidya()">
                            					<option value="0" selected>--------------Select-------------</option>
                            					<option value="1">Vidya</option>
                            					<option value="2">Special Vidya</option>
                            					<option value="3">Refundable Deposit Under Vidya</option>
                            					</select></td>
                            					</tr>
                            					<%} else if (strProductType.equalsIgnoreCase("pA") || strProductType.equalsIgnoreCase("p2")) {%>
                            					<tr>
								<td width="21%">Type of Vehicle<span class="mantatory">*</span></td>
								<td colspan="2" width="21%">
                         
                            	<select name="prd_typeofloan" tabindex="1" onChange="enableVehicle()">
									<option value="0" selected>---- Select ----</option>
									<option value="1">Two Wheeler</option>
									<option value="2">Four Wheeler - New</option>
									<option value="3">Four Wheeler - Used</option>
								</select></td>
								</tr>
								<%}else if (strProductType.equalsIgnoreCase("pH")) {%>
            					<tr>
								<td width="21%">Type of purpose<span class="mantatory">*</span></td>
								<td colspan="2" width="21%">
                         
                            	<select name="prd_typeofloan" tabindex="1" onChange="callVisibility()">
									<option value="0" selected>--------------------------------------------- Select ------------------------------------------</option>
									<option value="1">Purchase of ready built house/flat</option>
									<option value="2">Acquisition  of land & construction of house</option>
									<option value="3">Purchase of plot</option>
									<option value="4">Construction of house</option>
									<option value="5">Repair/Renovation/Remodeling/Extension of house</option>
									<option value="6">Purchase of plot for subsequent construction of house</option>
									<option value="7">Purchase of house and immediate repair/renovation/remodeling/extension</option>
								</select></td>
								</tr>
								<%}else if(strProductType.equalsIgnoreCase("pG")){ %>
                            <tr >
                            	<td width="21%">Type of Loan<span class="mantatory">*</span></td>
                            	<td colspan="2" width="21%">
                            	
                            	<select name="prd_typeofloan" tabindex="1" onChange="callbusiness()">
                            					<option value="0" selected>--------------Select-------------</option>
                            				<!-- 	<option value="1">General</option>
                            					<option value="2">Special</option> -->
                            					<option value="3">Business</option>
                            					<option value="4">Easy Gold</option>
                            				<!-- 		<option value="5">Pure Gold General</option> -->
                            					<option value="6">Own Your Gold</option>
                            					<option value="7">Gold Equity</option>
                            					</select></td>
                            					</tr>
                            	<%} %>
                            	<tr>
								<td width="21%">Type of Vehicle<span class="mantatory">*</span></td>
								<td colspan="2" width="21%">
                         
                            	<select name="prd_typeofloan" tabindex="1" onChange="enableVehicle()">
									<option value="0" selected>---- Select ----</option>
									<option value="1">Two Wheeler</option>
									<option value="2">Four Wheeler - New</option>
									<option value="3">Four Wheeler - Used</option>
								</select></td>
								</tr>
								<tr>
								 <%if(strProductType.equalsIgnoreCase("pE")||strProductType.equalsIgnoreCase("pH") || strProductType.equalsIgnoreCase("p3")){ %>
									<td width="21%" id="id1" style="visibility:hidden;position:absolute">
									Max. Limit for loan (Employed)</td>
								<td width="21%" id="id2" style="visibility:hidden;position:absolute"><input type="text" name="prd_collpass" maxlength="3" size="8"
									onKeyPress="allowNumber(this)" onPaste="window.event.returnValue=false"
									value="<%=Helper.correctNull((String)hshValues.get("prd_collpass"))%>"
									onBlur="roundtxt(this)" maxlength="4" style="text-align:right" tabindex="2">
									
								times of Annual <br>
								Income 
								
								
							</td><%} %>
							 <%if(strProductType.equalsIgnoreCase("pE")||strProductType.equalsIgnoreCase("pH") || strProductType.equalsIgnoreCase("p3")){ %>
								<td width="22%" id="id3" style="visibility:hidden;position:absolute">Max. Limit for loan (Self Employed)</td>
								<td width="20%" id="id4" style="visibility:hidden;position:absolute"><input type="text" name="prd_liqpass" maxlength="3" size="8"
									value="<%=Helper.correctNull((String)hshValues.get("prd_liqpass"))%>"
									onKeyPress="allowNumber(this)" onPaste="window.event.returnValue=false"
									 onBlur="roundtxt(this)" maxlength="4"
									style="text-align:right" tabindex="3"> times of Annual<br>
									 Income</td>
									 <%} %>
								<%if (strProductType.equalsIgnoreCase("pZ")) {%>
								<td width="22%">Total months-rent receivables</td>
								<td width="20%"><input type="text" name="prd_noofmon" size="8"
									value="<%=Helper.correctNull((String)hshValues.get("prd_noofmonths"))%>"
									onKeyPress="allowNumber(this)"
										onPaste="window.event.returnValue=false"  onBlur="roundtxt(this)" maxlength="4"
									style="text-align:right"  tabindex="3"></td>
								<%}%>

							</tr>
							
							<tr>
							<%if (strProductType.equalsIgnoreCase("pP") || strProductType.equalsIgnoreCase("pC") || strProductType.equalsIgnoreCase("p1")  || strProductType.equalsIgnoreCase("p4")) {%>
								<td width="21%">Max. Limit for loan <br>(Salaried)</td>
								<td width="21%"><input type="text" name="prd_pp_limit_emp_notobt" size="10"
									onKeyPress="allowInteger(this)" onPaste="window.event.returnValue=false"
									value="<%=Helper.correctNull((String)hshValues.get("prd_pp_limit_emp_notobt"))%>"
									onBlur="" maxlength="2" style="text-align:right" tabindex="5">
								times of monthly gross income </td>
								<%} %>
								<%if (strProductType.equalsIgnoreCase("pP") || strProductType.equalsIgnoreCase("p1") || strProductType.equalsIgnoreCase("p4")){%>
								<td width="21%">Max. Limit for loan <br>(Other than salaried)</td>
								<td width="21%"><laps:CurrencyTag name="prd_collateralsec" maxlength="6" size="10"
									onKeyPress="allowNumber(this)" style="text-align:right"
									onBlur="checkPercentage(this);roundtxt(this)"
									value='<%=Helper.correctNull((String)hshValues.get("prd_collateralsec"))%>'
									 tabindex="5" />% of annual income</td>
									 <%} %>
									 <%if (strProductType.equalsIgnoreCase("pC")){%>
									 <td width="21%">Max. Limit for loan <br>(Other than salaried)</td>
								<td width="21%"><input type="text" name="prd_noofmon" size="8"
									value="<%=Helper.correctNull((String)hshValues.get("prd_noofmonths"))%>"
									onKeyPress="allowNumber(this)"
										onPaste="window.event.returnValue=false"  onBlur="checkPercentage(this);roundtxt(this)" maxlength="6"
									style="text-align:right"  tabindex="5">% of annual income</td>
									 <%} %>
									 
							</tr>
						
							
							<%if (strProductType.equalsIgnoreCase("pH") ){ %>
							<tr>
								<td width="21%" id="housingid1">Minimum percentage of building value to the total property value
								</td>
								<td width="21%" id="housingid2"><input type="text" maxlength="6" name="prd_collweight" size="8"
									onKeyPress="allowNumber(this)" onPaste="window.event.returnValue=false"
									value="<%=Helper.correctNull((String)hshValues.get("prd_collweight"))%>"
									onBlur="checkPercentage(this);roundtxt(document.prdinterestfrm.prd_collweight)"
									maxlength="3"
									 style="text-align:right" tabindex="5"></td>
								<td width="15%" id="housingid5"> Financing second house margin shall be over than the normal margin by (%)</td>
								<td width="21%" id="housingid6"><laps:CurrencyTag  name="prd_collselfemployed" maxlength="3" size="8"
									value='<%=Helper.correctNull((String)hshValues.get("prd_repayselfemp"))%>'
									maxlength="6" tabindex="6"  
									onBlur="checkPercentage(this);roundtxt(this)"/></td>
								<td width="21%" id="housingid7">Maximum take over limit with top-up facility(%)</td>
								<td width="21%" id="housingid8"><laps:CurrencyTag name="prd_allowance" maxlength="6" size="10"
									onKeyPress="allowNumber(this)"  
									value='<%=Helper.correctNull((String)hshValues.get("prd_allowance"))%>'
									onBlur="checkPercentage(this);roundtxt(this)"
									 tabindex="7" /></td>
							<%}else if(strProductType.equalsIgnoreCase("pE") || strProductType.equalsIgnoreCase("p3")){ %>
							<td width="21%" id="specialvidyaid11">Minimum basic pay for salaried Co-obligant</td>
								<td width="21%" id="specialvidyaid2"><input type="text" maxlength="9" name="prd_collweight" size="12"
									onKeyPress="allowNumber(this)" onPaste="window.event.returnValue=false"
									value="<%=Helper.correctNull((String)hshValues.get("prd_collweight"))%>"
									onBlur="roundtxt(this)"
									maxlength="3" style="text-align:right" tabindex="5"></td>
								<td width="21%" id="specialvidyaid3">Minimum annual income for other than salaried Co-obligant</td>
								<td width="21%" id="specialvidyaid4"><laps:CurrencyTag name="prd_collselfemployed" maxlength="8" size="9"
									value='<%=Helper.correctNull((String)hshValues.get("prd_repayselfemp"))%>'
									onBlur="roundtxt(this)"
									maxlength="8" tabindex="6" /></td>									
								<td width="21%" id="eduliquidid1">Liquid security coverage</td>
								<td width="21%" id="eduliquidid2"><laps:CurrencyTag name="prd_allowance" maxlength="3" size="10"
									onKeyPress="allowNumber(this)"
									onBlur="roundtxt(this)"
									value='<%=Helper.correctNull((String)hshValues.get("prd_allowance"))%>'
									maxlength="6" tabindex="7" /></td>
									<%}else if(strProductType.equalsIgnoreCase("pP") || strProductType.equalsIgnoreCase("pC") || strProductType.equalsIgnoreCase("p1") || strProductType.equalsIgnoreCase("p4")){%>
									<td width="21%">Minimum monthly basic pay for salaried applicant</td>
								<td width="21%"><input type="text" maxlength="9" name="prd_collweight" size="14"
									onKeyPress="allowNumber(this)" onPaste="window.event.returnValue=false"
									value="<%=Helper.correctNull((String)hshValues.get("prd_collweight"))%>"
									onBlur="roundtxt(this)"
									 style="text-align:right" tabindex="6"></td>
								<td width="21%">Minimum annual income for other than salaried applicant</td>
								<td width="21%"><laps:CurrencyTag name="prd_collselfemployed" maxlength="9" size="14"
									value='<%=Helper.correctNull((String)hshValues.get("prd_repayselfemp"))%>'
									onBlur="roundtxt(this)"
									 tabindex="6" /></td>													
									<%} %>
									<%if(strProductType.equalsIgnoreCase("pC")){ %>
									<td width="21%">Minimum monthly gross pay for salaried applicant</td>
									<td width="21%"><laps:CurrencyTag name="prd_allowance" maxlength="9" size="14"
									onKeyPress="allowNumber(this)"
									onBlur="roundtxt(this)"
									value='<%=Helper.correctNull((String)hshValues.get("prd_allowance"))%>'
									 tabindex="7" /></td>
									
									<%} %>
									
									
							</tr>
							<% if(strProductType.equalsIgnoreCase("pT")){%>
							<tr>
							<td width="21%">Eligible percentage of the total value of the property for the value of the house
								</td>
							<td width="21%"><input type="text" maxlength="6" name="prd_collweight" size="8"
									onKeyPress="allowNumber(this)" onPaste="window.event.returnValue=false"
									value="<%=Helper.correctNull((String)hshValues.get("prd_collweight"))%>"
									onBlur="checkPercentage(this);roundtxt(document.prdinterestfrm.prd_collweight)"
									maxlength="3"
									 style="text-align:right" tabindex="1"></td>
							<td width="21%">Maximum age for the building<br>
								(In Years)</td>
							<td width="21%"><input type="text" maxlength="3" name="prd_pp_limit_pensioner" size="8"
									onKeyPress="allowInteger(this)" onPaste="window.event.returnValue=false"
										value="<%=Helper.correctNull((String)hshValues.get("prd_pp_limit_pensioner")) %>"
									maxlength="6" style="text-align:right" tabindex="2" /></td>
							</tr>
							
							<%} %>
							
								<% if(strProductType.equalsIgnoreCase("pB")){%>
							<tr>
								 <td width="21%">For deposit in Federal Bank,security coverage(%) </td>
									<td width="21%"><input type="text" maxlength="6" name="prd_collweight" size="10"
									onKeyPress="allowNumber(this)" onPaste="window.event.returnValue=false"
									value="<%=Helper.correctNull((String)hshValues.get("prd_collweight"))%>"
									onBlur="roundtxt(this)"
									 style="text-align:right" tabindex="7"></td>
								<td width="21%"> Other liquid security coverage</td>
								<td width="21%"><laps:CurrencyTag name="prd_allowance"  size="10"
									onKeyPress="allowNumber(this)"
									onBlur="roundtxt(this)"
									value='<%=Helper.correctNull((String)hshValues.get("prd_allowance"))%>'
									maxlength="6" tabindex="7"/></td>
									
									
									
							</tr>
							<%} %>
							<%if(!(strProductType.equalsIgnoreCase("pF")||strProductType.equalsIgnoreCase("pE") || strProductType.equalsIgnoreCase("p3"))){%>
									<tr style="visibility: hidden;position: absolute">
									<td width="21%">Max. Permissible age for salaried&nbsp;<br>
								(In Years)</td>
								<td width="21%"><input type="text" maxlength="2" name="prd_empretireage" size="8"
									onKeyPress="allowInteger(this)" 
									onPaste="window.event.returnValue=false" onBlur="checkRetirementAge(this);"
									value="<%=prd_empretireage%>" maxlength="6" style="text-align:right" tabindex="7" />
								</td>
								<td width="20%">Max. Permissible age for other than salaried&nbsp;
								(In Years)</td>
								<td width="15%"><input type="text" maxlength="2" name="prd_selfretireage" size="8"
									onKeyPress="allowInteger(this)" onPaste="window.event.returnValue=false"
									value="<%=Helper.correctNull((String)hshValues.get("prd_selfretireage"))%>"
									maxlength="6" style="text-align:right" tabindex="7" /> </td>
									<%if(strProductType.equalsIgnoreCase("p1")||strProductType.equalsIgnoreCase("p4")){ %>
							<td width="21%">Difference in interest rate for Home Plus Scheme(%)</td>
									<td width="21%"><input type="text" name="prd_procfees1" maxlength="6" size="10"
									onKeyPress="allowNumber(this)" style="text-align:right"
									onBlur="checkPercentage(this);roundtxt(this)"
									value='<%=Helper.correctNull((String)hshValues.get("prd_procfees1"))%>'
									 tabindex="14" /></td>
								
							<%} %>
									</tr>
									<%}%>
									
							<tr>
								<% if(strProductType.equalsIgnoreCase("pE")|| strProductType.equalsIgnoreCase("p3")){%>
								<td width="21%">Max. Repayment period &nbsp;<span class="mantatory">*</span><br>
								(In Months)</td>
								<td width="21%"><input type="text"  name="prd_empretireage" size="8"
									onKeyPress="allowInteger(this)" onBlur="" onPaste="window.event.returnValue=false"
									value="<%=Helper.correctNull((String)hshValues.get("prd_empretireage"))%>" maxlength="3" style="text-align:right" tabindex="8" />
								</td>
								
								<td width="20%">Max. Course Period&nbsp;<span class="mantatory">*</span><br>
								(In Months)</td>
								<td width="15%"><input type="text" maxlength="3" name="prd_selfretireage" size="8"
									onKeyPress="allowInteger(this)" onPaste="window.event.returnValue=false"
									value="<%=Helper.correctNull((String)hshValues.get("prd_selfretireage"))%>"
									 style="text-align:right" tabindex="8" /> </td>
									<%} %>
									
										<% if(strProductType.equalsIgnoreCase("pH") ){ %>
										<td width="21%" id="housingid9">Additional components(*) don't exceed how much % of loan amount   </td>
								<td width="21%" id="housingid10"><input type="text" maxlength="2" name="prd_procfees1" size="8"
									onKeyPress="allowNumber(this)" onPaste="window.event.returnValue=false"
									onBlur="checkPercentage(this);roundtxt(this)"
									value="<%=Helper.correctNull((String)hshValues.get("prd_procfees1"))%>"
									maxlength="6" style="text-align:right" tabindex="7" /> </td>
									
									<td width="21%" style="visibility:hidden;position:absolute">Loan To Value(LTV) Ratio</td>
									<td width="21%" style="visibility:hidden;position:absolute"><laps:CurrencyTag name="prd_collateralsec" maxlength="6" size="10"
									onKeyPress="allowNumber(this)" style="text-align:right"
									onBlur="checkPercentage(this);roundtxt(this)"
									value='<%=Helper.correctNull((String)hshValues.get("prd_collateralsec"))%>'
									 tabindex="7" /></td>
								
								<%} %>
									
									<%if(strProductType.equalsIgnoreCase("pE")|| strProductType.equalsIgnoreCase("p3")){ %>
								<td width="21%" id="eduid1">Max. Cushion period&nbsp;<span class="mantatory">*</span><br>
								(In Months)</td>
								<td width="21%" id="eduid2"><input type="text" maxlength="3" name="prd_nri_eligibleage" size="8"
									onKeyPress="allowInteger(this)" onPaste="window.event.returnValue=false"
										value="<%=Helper.correctNull((String)hshValues.get("prd_nri_eligibleage")) %>"
								 style="text-align:right" tabindex="12" /></td>
									<%} %>
							</tr>
							<tr>
								<%if(strProductType.equalsIgnoreCase("pH") || strProductType.equalsIgnoreCase("pT") || strProductType.equalsIgnoreCase("pA") || strProductType.equalsIgnoreCase("pC") || strProductType.equalsIgnoreCase("p2")) {%>
								<!-- <td width="21%">Minimum inward remittance by the borrower </td>
								<td width="21%"><input type="text"  name="prd_collateralsec" size="8"
									onKeyPress="allowDecimal(this)" onPaste="window.event.returnValue=false"
									value="<%=Helper.correctNull((String)hshValues.get("prd_collateralsec"))%>"
									maxlength="5" onBlur="checkPercentage(this);roundtxt(this)" style="text-align:right" tabindex="13" /> % of Monthly Income</td> -->
									<%}%>
									<%if(strProductType.equalsIgnoreCase("pE")|| strProductType.equalsIgnoreCase("p3")) { %>
									<td  width="21%" id="specialvidyaid5">Max. Eligible age for the guardian at the end of the loan period.&nbsp;<span class="mantatory" id="maxelistr"></span><br>
								(In Years)</td>
								<td id="specialvidyaid6"><input type="text" maxlength="2" name="prd_pp_limit_pensioner" size="8"
									value="<%=Helper.correctNull((String)hshValues.get("prd_pp_limit_pensioner"))%>"
									onKeyPress="allowNumber(this)" onBlur="" 
									onPaste="window.event.returnValue=false" style="text-align:right" tabindex="17"></td>
							<!-- 	 <td width="21%">Coll.sec Coverage Ratio</td>
								<td width="21%"><input type="text"  name="prd_collateralsec" size="8"
									onKeyPress="allowDecimal(this)"
									value="<%=Helper.correctNull((String)hshValues.get("prd_collateralsec"))%>"
									maxlength="5" onBlur="" style="text-align:right" tabindex="13" /></td> -->
								<%} %>
								
								<%if(strProductType.equalsIgnoreCase("pH") ){ %>
								<td  width="21%" id="housingid11">Loan component for Remodelling/Repair/Renovation don't exceed 
								how much % of loan amount
								</td>
								<td  width="21%" id="housingid12"><input type="text" name="prd_docfees1" size="9"
									value="<%=Helper.correctNull((String)hshValues.get("prd_docfees1"))%>"
									onKeyPress="allowNumber(this)" 
									onPaste="window.event.returnValue=false"
									 onBlur="checkPercentage(this);roundtxt(this)" maxlength="6"
									style="text-align:right" tabindex="14"></td>
									<td  width="21%" id="housingid13">Loan shall not exceed how much % of the value of building
								</td>
								<td  width="21%" id="housingid14"><input type="text" name="prd_docfees2" size="9"
									value="<%=Helper.correctNull((String)hshValues.get("prd_docfees2"))%>"
									onKeyPress="allowNumber(this)" 
									onPaste="window.event.returnValue=false"
									 onBlur="checkPercentage(this);roundtxt(this)" maxlength="6"
									style="text-align:right" tabindex="14"></td>
								<%} %>
								<td width="21%" style="visibility: hidden;position: absolute">Periodical Inspection</td>
								<td width="21%" style="visibility: hidden;position: absolute"><input type="hidden" name="prd_liqweight" size="8"
									onKeyPress="allowNumber(this)"
									value="<%=Helper.correctNull((String)hshValues.get("prd_liqweight"))%>"
									onBlur="roundtxt(this)"
									maxlength="6" style="text-align:right" tabindex="14"> 
									<select
									name="selperiod" style="width:100" tabindex="14">
									<option value="S" selected>---- Select ----</option>
									<option value="1">Monthly</option>
									<option value="2">Quarterly</option>
									<option value="3">Half Yearly</option>
									<option value="4">Yearly</option>
								</select></td>
								<%if(strProductType.equalsIgnoreCase("p5")){ %>
							<td width="21%">Difference in interest rate for Home Plus Scheme(%)</td>
									<td width="21%"><input type="text" name="prd_noofmon" maxlength="6" size="10"
									onKeyPress="allowNumber(this)" style="text-align:right"
									onBlur="checkPercentage(this);roundtxt(this)"
									value='<%=Helper.correctNull((String)hshValues.get("prd_noofmonths"))%>'
									 tabindex="7" /></td>
								
							<%} %>
								<%if(strProductType.equalsIgnoreCase("p3")||strProductType.equalsIgnoreCase("p2")){ %>
							<td width="21%">Difference in interest rate for Home Plus Scheme(%)</td>
									<td width="21%"><input type="text" name="prd_procfees1" maxlength="6" size="10"
									onKeyPress="allowNumber(this)" style="text-align:right"
									onBlur="checkPercentage(this);roundtxt(this)"
									value='<%=Helper.correctNull((String)hshValues.get("prd_procfees1"))%>'
									 tabindex="14" /></td>
								
							<%} %>
								
								<%if(strProductType.equalsIgnoreCase("pG")){ %>
								<td id="goldid1" width="21%">Liquid security coverage
								</td>
								<td id="goldid2" width="21%"><input type="text" name="prd_noofmon" size="9"
									value="<%=Helper.correctNull((String)hshValues.get("prd_noofmonths"))%>"
									onKeyPress="allowNumber(this)" 
									onPaste="window.event.returnValue=false"
									 onBlur="checkPercentage(this);roundtxt(this)" maxlength="6"
									style="text-align:right" tabindex="14"></td>
								<%} %>
								<%if(strProductType.equalsIgnoreCase("pM")){ %>
								<td width="21%">For bank official,margin shall be over than external valuer margin by
								</td>
								<td width="21%"><input type="text" name="prd_noofmon" size="9"
									value="<%=Helper.correctNull((String)hshValues.get("prd_noofmonths"))%>"
									onKeyPress="allowNumber(this)" 
									onPaste="window.event.returnValue=false"
									 onBlur="checkPercentage(this);roundtxt(this)" maxlength="6"
									style="text-align:right" tabindex="14"></td>
								<%} %>
								<%if(strProductType.equalsIgnoreCase("pP") || strProductType.equalsIgnoreCase("p1") || strProductType.equalsIgnoreCase("p4")){ %>
								<td width="21%">Loan installments not to exceed </td>
								<td width="21%"><laps:CurrencyTag name="prd_margin" maxlength="6" size="8"
									value='<%=Helper.correctNull((String)hshValues.get("prd_margin"))%>'
									onBlur="checkPercentage(this);roundtxt(this)"
									 tabindex="15" /> % of last month's salary credit</td>	
									 <%} %>
									 <%if (strProductType.equalsIgnoreCase("pB")) { %>
								
								<td >EMI shall not exceed how much % of prospective/possible monthly inward remittances by the borrower after taking up proposed employment abroad
								</td>
								<td><input type="text" name="prd_noofmon" size="9"
									value="<%=Helper.correctNull((String)hshValues.get("prd_noofmonths"))%>"
									onKeyPress="allowNumber(this)" 
									onPaste="window.event.returnValue=false"
									 onBlur="checkPercentage(this);roundtxt(this)" maxlength="6"
									style="text-align:right" tabindex="14"></td>
							
								
									<%} %>
									
		
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								</tr>
								
								<tr >
								<%if (!strProductType.equalsIgnoreCase("pE") && (!strProductType.equalsIgnoreCase("pF")) && (!strProductType.equalsIgnoreCase("p3"))) { %>
								<td  width="21%" style="visibility: hidden;position: absolute"> Maximum holiday period</td>
								<td  width="21%" style="visibility: hidden;position: absolute"><input type="text" maxlength="3" name="prd_holiday" size="8"
									onKeyPress="allowInteger(this)"
										onBlur="callRepayment()" onPaste="window.event.returnValue=false"
									value="<%=Helper.correctNull((String)hshValues.get("prd_repayhol"))%>"
									 style="text-align:right" tabindex="15" /> Months</td>
								<%} %>
							
								<td width="21%" style="visibility: hidden;position: absolute">Addition of Co-applicant/Co-obligant income</td>
								<td width="21%" style="visibility: hidden;position: absolute">
										
								<select name="coguincome" style="width:100" tabindex="16" style="visibility: hidden;position: absolute">
									<option value="0" selected>---- Select ----</option>
									<option value="1">Yes</option>
									<option value="2">No</option>

								</select></td>
								<% if(strProductType.equalsIgnoreCase("pE")|| strProductType.equalsIgnoreCase("p3")){ %>
								
								<td id="s1">Caution Deposit,Building Fund and Refundable Deposit 
									should not exceed</td>
								<td id="s2"><input type="text"  name="prd_collateralsec" size="8"
									onKeyPress="allowDecimal(this)"
									value="<%=Helper.correctNull((String)hshValues.get("prd_collateralsec"))%>"
									maxlength="5" 
									onPaste="window.event.returnValue=false" onBlur="checkPercentage(this);roundtxt(this)" 
									style="text-align:right" tabindex="13" /> % of the Tuition Fee</td>
									
								<%} %>
								
							</tr>
								<% if(strProductType.equalsIgnoreCase("p1") || strProductType.equalsIgnoreCase("p2")
										||strProductType.equalsIgnoreCase("p3")||strProductType.equalsIgnoreCase("p4")
										||strProductType.equalsIgnoreCase("p5")){%>
										<tr>
										<td>Table Code same as Existing Housing Loan<span class="mantatory">*</span></td>
										<td><select name="sel_tablecode" style="width:100" >
											<option value="S" selected>---- Select ----</option>
											<option value="Y" >Yes</option>
											<option value="N" >No</option>
										</select></td>
										</tr>
										
										<%} %>
							
								<% if(strProductType.equalsIgnoreCase("pB")){%>
								<tr>
								<td colspan="2">Maximum number of months from the holiday period<br></td>
								</tr>
								<tr>
								<td>(a) From the date of departure</td>
								<td width="21%"><input type="text" maxlength="3" name="prd_pp_limit_pensioner" size="8"
									value="<%=Helper.correctNull((String)hshValues.get("prd_pp_limit_pensioner"))%>"
									onKeyPress="allowInteger(this)" onBlur="" maxlength="3"
									onPaste="window.event.returnValue=false" style="text-align:right" tabindex="17"> </td>
								</tr>
								<tr>
								<td>(b) From the date of sanction</td>
								<td><input type="text" name="prd_pp_limit_emp_notobt" size="8"
									onKeyPress="allowInteger(this)" onPaste="window.event.returnValue=false"
									value="<%=Helper.correctNull((String)hshValues.get("prd_pp_limit_emp_notobt"))%>"
									onBlur="" maxlength="3" style="text-align:right" tabindex="18"> </td>
								</tr>
								<%} %>
							
							<%if (strProductType.equalsIgnoreCase("pH")) { %>
								
							<tr>
								<td  width="21%" id="housingid15">Age relaxation for parents whose son's or daughter's income is included</td>
								<td width="21%" id="housingid16"><input type="text" maxlength="3" name="prd_pp_limit_pensioner" size="8"
									value="<%=Helper.correctNull((String)hshValues.get("prd_pp_limit_pensioner"))%>"
									onKeyPress="allowInteger(this)" onBlur="" maxlength="4"
									onPaste="window.event.returnValue=false" style="text-align:right" tabindex="17"> Years</td>
									<td width="21%" id="housingid3">Total period including age of building and loan tenure
									shall not exceed</td>
									<td width="21%" id="housingid4"><input type="text" name="prd_pp_limit_emp_notobt" size="8"
									onKeyPress="allowInteger(this)" onPaste="window.event.returnValue=false"
									value="<%=Helper.correctNull((String)hshValues.get("prd_pp_limit_emp_notobt"))%>"
									onBlur="" maxlength="3" style="text-align:right" tabindex="18"> Years
									</td>
									
							 <td width="21%" id="housingid21">Margin for building construction</td>
									<td width="21%" id="housingid22"><input type="text" name="prd_procfees" size="10"
									onKeyPress="allowNumber(this)"  onPaste="window.event.returnValue=false"
									value="<%=Helper.correctNull((String)hshValues.get("prd_procfees")) %>" 
									 onBlur="checkPercentage(this);roundtxt(this)" maxlength="8" 
									 style="text-align: right" tabindex="18"></td>
										<td width="21%" id="housingid19">Margin for land</td>
									<td width="21%" id="housingid20"><input type="text" name="prd_procfees2" size="10"
									onKeyPress="allowNumber(this)"  onPaste="window.event.returnValue=false"
									value="<%=Helper.correctNull((String)hshValues.get("prd_procfees2")) %>" 
									 onBlur="checkPercentage(this);roundtxt(this)" maxlength="8"
									  style="text-align: right" tabindex="18"></td>
							
									
							</tr>
						<!--  
							<tr>
								<td colspan="6" id="housingid17">If loan amount is Rs.<input type="text" name="prd_noofmon" size="12"
									value="<%=Helper.correctNull((String)hshValues.get("prd_noofmonths"))%>"
									onKeyPress="allowNumber(this)" 
									onPaste="window.event.returnValue=false" onBlur="roundtxt(this)" maxlength="8"
									style="text-align:right" tabindex="19">or less,Branch managers are permitted to
									reduce margin to <input type="text" name="prd_margin" maxlength="8" size="8"
									value="<%=Helper.correctNull((String)hshValues.get("prd_margin"))%>"
									onKeyPress="allowNumber(this)"
										onPaste="window.event.returnValue=false" onBlur="checkPercentage(this);roundtxt(this)" maxlength="8"
									style="text-align:right" tabindex="20"> (%)</td></tr>-->
							
							<%} %>
						
							<%if(strProductType.equalsIgnoreCase("pP") || strProductType.equalsIgnoreCase("p1")  || strProductType.equalsIgnoreCase("p4")){ %>
								<tr>
								<td colspan="6">Collateral security is not required for salaried category who is maintaining
								salary account in Federal Bank for loan amount upto Rs.
								<input type="text" name="prd_noofmon" size="14"
									value="<%=Helper.correctNull((String)hshValues.get("prd_noofmonths"))%>"
									onKeyPress="allowNumber(this)" onPaste="window.event.returnValue=false"
									onBlur="roundtxt(this)" maxlength="9"
									style="text-align:right" tabindex="18">
								</td>
								</tr>
							<%} %>
							<tr>
							<%if(strProductType.equalsIgnoreCase("pA") || strProductType.equalsIgnoreCase("p2")){ %>
									<td width="20%" >If Agricultural income  is considered,the
									borrower should own atleast</td>
								<td><input type="text" maxlength="6" name="prd_margin" size="10"
									onKeyPress="allowNumber(this)" onBlur="roundtxt(this)"
										onPaste="window.event.returnValue=false"
									value="<%=Helper.correctNull((String)hshValues.get("prd_margin"))%>"
									maxlength="6" style="text-align:right" tabindex="17" /> acres of Land</td>
									
									<%} %>
									<%//if (strProductType.equalsIgnoreCase("pA") || strProductType.equalsIgnoreCase("p2") || strProductType.equalsIgnoreCase("aP") ) { %>
								<td id="idvehicle1" style="visibility:hidden;position:absolute" width="21%">Maximum age for used vehicle<span class="mantatory">*</span>
								<br>(In Years)</td>
								<td id="idvehicle2" style="visibility:hidden;position:absolute" width="21%"> <input type="text" maxlength="2" 

								name="prd_pp_limit_pensioner" size="8"
									onKeyPress="allowInteger(this)" onPaste="window.event.returnValue=false"
										value="<%=Helper.correctNull((String)hshValues.get("prd_pp_limit_pensioner"))%>" 

											
									maxlength="6" style="text-align:right" tabindex="15" /></td>
									<%//} %>
									</tr>
									
									<%//if(strProductType.equalsIgnoreCase("pA") || strProductType.equalsIgnoreCase("p2")|| strProductType.equalsIgnoreCase("aP") ){ %>
							<tr >
								<td id="idvehicle3" style="visibility:hidden;position:absolute" colspan="6">If loan amount is 
									<input type="text" name="prd_noofmon" size="13"
									value="<%=Helper.correctNull((String)hshValues.get("prd_noofmonths"))%>"
									onKeyPress="allowNumber(this)" 
										onPaste="window.event.returnValue=false"
									onBlur="checkPercentage(this);roundtxt(this)" maxlength="9"
									style="text-align:right" tabindex="18">
									% of ex-showroom price,security is not mandatory upto Rs.
									<input type="text"  name="prd_collweight" size="12"
									onKeyPress="allowNumber(this)"
									value="<%=Helper.correctNull((String)hshValues.get("prd_collweight"))%>"
									maxlength="8" 
									onPaste="window.event.returnValue=false"
									onBlur="roundtxt(this)" style="text-align:right" tabindex="19" />
									</td>
								</tr>
								<%//} %>
							
							
							
							<%if(strProductType.equalsIgnoreCase("pE")|| strProductType.equalsIgnoreCase("p3")){ %>
							<tr id="vidyaid1">
								<td colspan="6">For security, upto loan amount Rs.
										<input type="text" name="prd_noofmon" size="12"
									value="<%=Helper.correctNull((String)hshValues.get("prd_noofmonths"))%>"
									onKeyPress="allowNumber(this)" 
									onPaste="window.event.returnValue=false" onBlur="roundtxt(this)" maxlength="9"
									style="text-align:right" tabindex="17">
									Minimum no of Co-obligants is
									 <input type="text" name="prd_pp_limit_emp_notobt" size="8"
									onKeyPress="allowNumber(this)"
									value="<%=Helper.correctNull((String)hshValues.get("prd_pp_limit_emp_notobt"))%>"
									onBlur="roundtxt(this)" 
									onPaste="window.event.returnValue=false" maxlength="2" style="text-align:left" tabindex="18"> 
									</td>
								</tr>
								<tr id="specialvidyaid1">
								<td colspan="6">Optional third party guarantee for loan amount from 
										<input type="text" name="prd_docfees1" size="12"
									value="<%=Helper.correctNull((String)hshValues.get("prd_docfees1"))%>"
									onKeyPress="allowNumber(this)" 
									onPaste="window.event.returnValue=false" onBlur="roundtxt(this)" maxlength="9"
									style="text-align:right" tabindex="17">
									to
									 <input type="text" name="prd_docfees2" size="12"
									onKeyPress="allowNumber(this)"
									value="<%=Helper.correctNull((String)hshValues.get("prd_docfees2"))%>"
									onBlur="roundtxt(this)"  
									onPaste="window.event.returnValue=false" maxlength="9" style="text-align:right" tabindex="18"> 
									</td>
								</tr>
									
								
									<%} %>
							
							
							
						
							<!--  <tr>
								<td  width="21%">Max. Loan Period<br>
								(In Months)</td>
								<td ><input type="text" maxlength="2" name="prd_pp_limit_pensioner" size="8"
									value="<%=Helper.correctNull((String)hshValues.get("prd_pp_limit_pensioner"))%>"
									onKeyPress="allowNumber(this)" onBlur="" maxlength="4"
									onPaste="window.event.returnValue=false" style="text-align:right" tabindex="17"></td>
							</tr>-->
							<!-- Anitha -  -->
							<%if(strProductType.equalsIgnoreCase("pD")){ %>
								<tr>
									<td>Maximum loan amount against NRE+FCAB</td>
									<td><input type="text" maxlength="12" name="prd_procfees" size="15"
									value="<%=Helper.correctDouble((String)hshValues.get("prd_procfees"))%>"
									onKeyPress="allowNumber(this)" onBlur="roundtxt(this)"
									onPaste="window.event.returnValue=false" style="text-align:right" ></td>
									<td>Interest rate to be added with deposit ROI</td>
									<td><input type="text" maxlength="6" name="txt_prd_intrate_roi" size="15"
									value="<%=Helper.correctDouble((String)hshValues.get("prd_intrate_roi"))%>"
									onKeyPress="allowNumber(this)" onBlur="roundtxt(this);checkPercentage(this)"
									onPaste="window.event.returnValue=false" style="text-align:right" ></td>
								</tr>
							<%}%>
							<%if(strProductType.equalsIgnoreCase("pL")){ %>
								<tr>
									<td>Security Type</td>
									<td><select name="sel_securitytype" onChange="callGovSecurities()">
									<option value="S" selected>-- Select --</option>
									<option value="MF">Mutual fund</option>
									<option value="GOV">Govt & other securities</option>
									<option value="NSC">NSC/KVP</option>
									<option value="LI">Life Insurance policies</option>
									</select></td>
									<td id="idnew1">Margin Against Security for Non-Cumulative Bonds</td>
									<td><input type="text" maxlength="6" name="prd_margin" size="10"
									onKeyPress="allowNumber(this)" onBlur="roundtxt(this);callper(this)""
										onPaste="window.event.returnValue=false"
									value="<%=Helper.correctNull((String)hshValues.get("prd_margin"))%>"
									maxlength="5" style="text-align:right"/></td>	</tr>
							<%}%>
							<!--  -->
							<%if(strProductType.equalsIgnoreCase("pF")){ %>
							<tr>
								<td width="35%" id="id1" >Minimum Monthly Disbursement(Rs.)</td>
								<td  id="id2" ><input type="text" name="prd_collpass" maxlength="8" size="8" 
									onKeyPress="allowNumber(this)" onPaste="window.event.returnValue=false"
									value="<%=Helper.correctNull((String)hshValues.get("prd_collpass"))%>"
									onBlur="roundtxt(this)" maxlength="8" style="text-align:right" tabindex="1"></td>
							
							<td  id="id3" >Maximum Monthly Disbursement(Rs.)</td>
								<td  id="id4" ><input type="text" name="prd_liqpass" maxlength="8" size="8"
									value="<%=Helper.correctNull((String)hshValues.get("prd_liqpass"))%>"
									onKeyPress="allowNumber(this)" onPaste="window.event.returnValue=false"
									 onBlur="roundtxt(this)" 
									style="text-align:right" tabindex="2"> </td>
							</tr>
							<tr>
							
							<td >Loan Period Of Borrower upto and Including <input type="text" size="5%" maxlength="3" name="prd_furmargin" value="<%=Helper.correctNull((String)hshValues.get("prd_furmargin")) %>" onBlur="changeLabel()"/>Years of Age</td>
									
									 
								<td width="15%"><input type="text" maxlength="3" name="prd_selfretireage" size="8"
									onKeyPress="allowInteger(this)" onPaste="window.event.returnValue=false"
									value="<%=Helper.correctNull((String)hshValues.get("prd_selfretireage"))%>"
									 style="text-align:right" tabindex="3" />&nbsp;(in months) </td>
							 <td width="21%" id="eduid1">Loan Period Of Borrower Above <input type="text" style="text-align: left; background-color: #EEF2F9; border-style: none; color: #000000; font-weight: bold" disabled size="5%" maxlength="2" name="age_label1" />Years of Age</td> 
								<td width="21%" id="eduid2"><input type="text" maxlength="3" name="prd_nri_eligibleage" size="8"
									onKeyPress="allowInteger(this)" onPaste="window.event.returnValue=false"
										value="<%=Helper.correctNull((String)hshValues.get("prd_nri_eligibleage")) %>"
								 style="text-align:right" tabindex="4" />&nbsp;(in months) </td>
							</tr>
							<tr>
							
							<td >Percentage of Value of the building to Eligibility based on margin</td>
								<td><input type="text" maxlength="6" name="prd_margin" size="10"
									onKeyPress="allowNumber(this)" onBlur="roundtxt(this);callper(this)""
										onPaste="window.event.returnValue=false"
									value="<%=Helper.correctNull((String)hshValues.get("prd_margin"))%>"
									maxlength="5" style="text-align:right" tabindex="5"/> </td>
									
							 <td width="21%" id="eduid1">Minimum Residual life of property</td>
								<td width="21%" id="eduid2"> <input type="text" name="prd_oldvehiclemargin" size="8" onKeyPress="allowNumber(this)" 
								value="<%=Helper.correctNull((String)hshValues.get("prd_oldvehiclemargin"))%>"
								 onBlur="" maxlength="4" style="text-align:right" tabindex="6" />&nbsp;(in months)</td>
							</tr>
							<tr>
							
							<td >Minimum age of the Applicant</td>
								<td width="21%"><input type="text" name="prd_pp_limit_emp_notobt" size="10"
									onKeyPress="allowInteger(this)" onPaste="window.event.returnValue=false"
									value="<%=Helper.correctNull((String)hshValues.get("prd_pp_limit_emp_notobt"))%>"
									maxlength="2" style="text-align:right" tabindex="7" />
								</td>
							 <td width="21%" id="eduid1">Minimum age of the Spouse</td>
								<td width="21%"><input type="text" maxlength="2" name="prd_pp_limit_pensioner" size="8"
									onKeyPress="allowInteger(this)" onPaste="window.event.returnValue=false"
										value="<%=Helper.correctNull((String)hshValues.get("prd_pp_limit_pensioner")) %>"
									 style="text-align:right" tabindex="8" /></td>
							</tr>
							<tr>
							
							<td >Reduction of tenor is possible only if the maturity date goes beyond the age</td>
								<td width="15%"><input type="text" maxlength="3" name="prd_creditbureau" size="8"
									onKeyPress="allowInteger(this)" onPaste="window.event.returnValue=false"
									value="<%=Helper.correctNull((String)hshValues.get("prd_creditbureau"))%>"
									 style="text-align:right" tabindex="9" /> </td>
							</tr>
							<%}%>
							<%if(strProductType.equalsIgnoreCase("pA")||strProductType.equalsIgnoreCase("p2")){
							%>
							<tr>
							<td colspan="4"> Land holding is not necessary for thr borrower with minimum monthly income of Rs.
								<input type="text" name="prd_intrate" onKeyPress="allowNumber(this)"
									onBlur="roundtxt(this)"
									 onPaste="window.event.returnValue=false" size="12" style="text-align:right" tabindex="10"
									 value="<%= Helper.correctNull((String)hshValues.get("prd_intrate"))%>"/>
								</td>
							</tr>
							<%} %>
							<tr>
							<td colspan="4" style="visibility:hidden;position:absolute">Pension income taken into account for the purpose should not be more than
								<input type="text" name="prd_addlint" onKeyPress="allowNumber(this)"
									onBlur="roundtxt(this);checkPercentage(this)"
									 onPaste="window.event.returnValue=false" size="8" style="text-align:right" tabindex="10"
									 value="<%= Helper.correctNull((String)hshValues.get("prd_addlint"))%>"/>
									 % of the total income of the borrower/spouse
								</td>
							</tr>
							<tr>
							<td colspan="4" style="visibility:hidden;position:absolute"> Income from pension should not be less than Rs.
								<input type="text" name="prd_totalint" onKeyPress="allowNumber(this)"
									onBlur="roundtxt(this)"
									 onPaste="window.event.returnValue=false" size="12" style="text-align:right" tabindex="10"
									 value="<%= Helper.correctNull((String)hshValues.get("prd_totalint"))%>"/>
									per month.

								</td>
							</tr>
							<tr>
								<td colspan="4"> MPBF computation eligible limit is
								<input type="text" name="prd_networth_percent" onKeyPress="allowNumber(this)"
									onBlur="roundtxt(this);checkPercentage(this)"
									 onPaste="window.event.returnValue=false" size="8" style="text-align:right" tabindex="10"
									 value="<%= Helper.correctNull((String)hshValues.get("prd_networth_percent"))%>"/>
									 % of networth of borrower 
								</td>
							</tr>
							<tr>
							<td colspan="4">
							<table>
							<tr>
							<td>
								Upto What Rating RCH can Sanction
							</td>
							<td>
							 <select name="prd_ratingdesc">
							 <option value="0" selected>----Select-----</option>
							 <%String strscoringpattern= Helper.correctNull((String)hshValues.get("scoringpattern")); %>
						     <laps:setratingdesc scoringpattern="<%=strscoringpattern%>"/>
                            </select>
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
			<%if(strProductType.equalsIgnoreCase("pH") ){ %>
			<tr>
			<td id="housingid18">(*) - Registration fee/Stamp duty, Compound wall/gate, Permanent fixtures/Kitchen cabinet</td>
			</tr>
			<%} %>
		</table>
		</td>
	</tr>
</table>


<br>
<table border="0" cellspacing="0" cellpadding="0" align="center"
	class="outertable border1">
	<tr>
		<td>
		<table width="100%" cellspacing="0" cellpadding="1" align="center">
			<tr valign="top">
				<td width="19%"><input type="button" class="buttonStyle"
					name="cmdedit" value="Edit" onClick="callEdit()"></td>
				<td width="20%"><input type="button" name="cmdapply" value="Apply"
					class="buttonStyle" onClick="callApply()" tabindex="7"></td>
				<td width="20%"><input type="button" name="cmdcancel" value="Cancel"
					class="buttonStyle" onClick="callCancel()"></td>
				<!--    <td width="18%"> 
                <input type="button" name="cmdhelp" value="Help" class="buttonHelp"  onClick="dohlpp()">
              </td> //-->
				<td width="23%"><input type="button" name="cmdclose" value="Close"
					class="buttonClose" onClick="doClose()"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
 
<input type=hidden name="hidBeanId" value="setinterest">
<input type=hidden name="hidBeanMethod" value="updateDataFacility"> 
<input type=hidden name="hidSourceUrl" value="/action/facilityinterest.jsp"> 
<input type=hidden name="hidSeldInsti" value=""> 
<input type=hidden name="hidActionMode" value="INSERT"> 
<input type=hidden name="hidBeanGetMethod" value="getDataFacility"> 
<input type="hidden" name="checkApp" value="<%=request.getParameter("checkApp")%>"> 
<input type="hidden" name="hidProducttype" value="<%=session.getAttribute("strProductType")%>">
<input type="hidden" name="fac_id1" value="<%=Helper.correctNull((String)request.getParameter("fac_id"))%>">
<input type="hidden" name="hidAgrScheme" value="<%=Helper.correctNull((String)request.getParameter("hidAgrScheme"))%>">
</form>
</body>
</html>
