<%@include file="../share/directives.jsp"%>
<%
	request.setAttribute("_cache_refresh", "true");
	String strTakeOver=Helper.correctNull((String) hshValues.get("phpa_take_over"));
	String strTakeOver_app=Helper.correctNull((String) hshValues.get("loan_takeover"));
	String strFreeze=Helper.correctNull((String)request.getParameter("hidFreeze"));
	String prd_typecheck = Helper.correctNull((String) session.getAttribute("strProductType"));	
	String strLoanpurpose = Helper.correctNull((String) hshValues.get("phpa_loan_purpose"));
	if(strLoanpurpose.equalsIgnoreCase(""))
	{
		strLoanpurpose = Helper.correctNull((String) hshValues.get("strProdPurpose"));
	}
	if(!(Helper.correctNull((String) hshValues.get("strSecId")).equalsIgnoreCase("")))
	{
		session.setAttribute("strSecId",(Helper.correctNull((String) hshValues.get("strSecId"))));
	}
	
	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();

	java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
	nf.setGroupingUsed(false);
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	
	String prd_type = Helper.correctNull((String) session.getAttribute("strProductType"));
	String strPrdPurpose=Helper.correctNull((String) session.getAttribute("strPrdPurpose"));
	String strProAvailableFor =Helper.correctNull((String) hshValues.get("prd_applicablefor"));
	int linkid=5;
	String strFreezeflag = Helper.correctNull((String)hshValues.get("strFreezeflag"));
	session.setAttribute("HouseEdit_Flag", Helper.correctNull((String)hshValues.get("HouseEdit_Flag")));
%>
<html>
<head>
<title>Proposed Asset</title>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/per/per_house_proposed_asset.js"></script>
<script>
var varOwnerList="";
var varRecordflag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var appno  ="<%=request.getParameter("appno")%>";

var var_loan_purpose="<%=strLoanpurpose%>";
var var_take_over="<%=Helper.correctNull((String) hshValues
							.get("phpa_take_over"))%>";
var var_prop_type="<%=Helper.correctNull((String) hshValues
							.get("phpa_prop_type"))%>";
var var_prop_nature="<%=Helper.correctNull((String) hshValues
							.get("phpa_prop_nature"))%>";
var var_prop_usedfor="<%=Helper.correctNull((String) hshValues
							.get("phpa_prop_usedfor"))%>";
var var_premises_age="<%=Helper.correctNull((String) hshValues
							.get("phpa_premises_age"))%>";
var var_residual_life="<%=Helper.correctNull((String) hshValues
							.get("phpa_residual_life"))%>";
var var_branch_distance="<%=Helper.correctNull((String) hshValues
							.get("phpa_branch_distance"))%>";
var var_prop_location="<%=Helper.correctNull((String) hshValues
							.get("phpa_prop_location"))%>";
var var_prop_surveyno="<%=Helper.correctNull((String) hshValues
							.get("phpa_prop_surveyno"))%>";
var var_prop_plotno="<%=Helper.correctNull((String) hshValues
							.get("phpa_prop_plotno"))%>";
var var_prop_street="<%=Helper.correctNull((String) hshValues
							.get("phpa_prop_street"))%>";
var var_prop_taluk="<%=Helper.correctNull((String) hshValues
							.get("phpa_prop_taluk"))%>";
var var_prop_city="<%=Helper.correctNull((String) hshValues
							.get("phpa_prop_city"))%>";
var var_prop_district="<%=Helper.correctNull((String) hshValues
							.get("phpa_prop_district"))%>";
var var_prop_state="<%=Helper.correctNull((String) hshValues
							.get("phpa_prop_state"))%>";
var var_prop_pincode="<%=Helper.correctNull((String) hshValues
							.get("phpa_prop_pincode"))%>";
var var_site_area="<%=Helper.correctDouble((String) hshValues
							.get("phpa_site_area"))%>";
var var_floorspace_area="<%=Helper.correctDouble((String) hshValues
							.get("phpa_floorspace_area"))%>";
var var_site_market_value="<%=Helper.correctDouble((String) hshValues
							.get("phpa_site_market_value"))%>";
var var_site_purchase_price="<%=Helper.correctDouble((String) hshValues
							.get("phpa_site_purchase_price"))%>";
var var_site_valuation_cost="<%=Helper.correctDouble((String) hshValues
							.get("phpa_site_valuation_cost"))%>";
var var_bldg_market_value="<%=Helper.correctDouble((String) hshValues
							.get("phpa_bldg_market_value"))%>";
var var_bldg_purchase_price="<%=Helper.correctDouble((String) hshValues
							.get("phpa_bldg_purchase_price"))%>";
var var_bldg_valuation_cost="<%=Helper.correctDouble((String) hshValues
							.get("phpa_bldg_valuation_cost"))%>";
var var_bldg_estimate_cost="<%=Helper.correctDouble((String) hshValues
							.get("phpa_bldg_estimate_cost"))%>";
var var_bldg_rennovation_cost="<%=Helper.correctDouble((String) hshValues
							.get("phpa_bldg_rennovation_cost"))%>";
var var_project_name="<%=Helper.correctNull((String) hshValues
							.get("phpa_project_name"))%>";
var var_project_details="<%=Helper.correctNull((String) hshValues
							.get("phpa_project_details"))%>";
var var_builder_name="<%=Helper.correctNull((String) hshValues
							.get("phpa_builder_name"))%>";
var var_builder_background="<%=Helper.correctNull((String) hshValues
							.get("phpa_builder_background"))%>";
var var_project_finance="<%=Helper.correctNull((String) hshValues
							.get("phpa_project_finance"))%>";
var var_loc_road="<%=Helper.correctNull((String) hshValues
							.get("phpa_loc_road"))%>";
var var_loc_market="<%=Helper.correctNull((String) hshValues
							.get("phpa_loc_market"))%>";
var var_loc_public="<%=Helper.correctNull((String) hshValues
							.get("phpa_loc_public"))%>";
var var_loc_neighbourhood="<%=Helper.correctNull((String) hshValues
							.get("phpa_loc_neighbourhood"))%>";
var var_ame_road="<%=Helper.correctNull((String) hshValues
							.get("phpa_ame_road"))%>";
var var_ame_water="<%=Helper.correctNull((String) hshValues
							.get("phpa_ame_water"))%>";
var var_ame_drainage="<%=Helper.correctNull((String) hshValues
							.get("phpa_ame_drainage"))%>";
var var_ame_electricity="<%=Helper.correctNull((String) hshValues
							.get("phpa_ame_electricity"))%>";
var var_already_mortgage="<%=Helper.correctNull((String) hshValues
							.get("phpa_already_mortgage"))%>";
var varAppStatus = "<%=Helper.correctNull((String)request.getParameter("strappstatus"))%>";
var varRepayment = "<%=Helper.correctNull((String)hshValues.get("lreqterms"))%>";	
var varLimit = "<%=Helper.correctNull((String)hshValues.get("prd_repayperiodhouse"))%>";
var varsecurtype =  "<%=Helper.correctNull((String)hshValues.get("phpa_ame_securtype"))%>";
var varsecurclassfic =  "<%=Helper.correctNull((String)hshValues.get("phpa_ame_securclassific"))%>";
var varstrFreeze="<%=strFreeze%>";
var varprd_type="<%=prd_type%>";
var varProAvailableFor="<%=strProAvailableFor%>";
var var_natureCharge =  "<%=Helper.correctNull((String)hshValues.get("phpa_natureofcharge"))%>";
var varOldAppId ="<%=Helper.correctNull((String)hshValues.get("oldAppid"))%>";
var var_row;

 //var vartakeover="<%=Helper.correctNull((String) request.getParameter("hidtakeover"))%>";

var vartakecare="<%=Helper.correctNull((String)hshValues.get("loan_takeover"))%>";

var varhousetype="<%=Helper.correctNull((String)hshValues.get("PHPA_HOUSE_TYPE"))%>";
var vargovtscheme="<%=Helper.correctNull((String)hshValues.get("govt_scheme"))%>";

var loan_costproj="<%=Helper.checkDecimal(Helper.correctDouble((String) hshValues.get("loan_costproj")))%>";
var var_metlife="<%=Helper.checkDecimal(Helper.correctDouble((String) hshValues.get("phpa_metlifepremiumamt")))%>";
var strSessionModuleType="<%=strSessionModuleType%>";
function showSpecify(flag)
{
	
}
function showCitySearch1(varTextControl,varTextControl1,varHidControl,varHidControl1,varTextControl2,varHidControl2)
{
	if(document.forms[0].cmdsave.disabled==false && document.forms[0].hidsecID.value=="" )
		{
		var varDemoflag="prophouse";
		var varQryString = appURL+"action/searchCity.jsp?hidcitycontrol="+varTextControl+"&hidstatecontrol="+varTextControl1+"&hidcitycodecontrol="+varHidControl+"&hidstatecodecontrol="+varHidControl1+"&hidzipcontrol="+varTextControl2+"&hidzipvaildatorcontrol="+varHidControl2+"&vardemo="+varDemoflag;
		var title = "City";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
		}
}

function showDistSearch(val)
{  

	var varstate = document.forms[0].hidstate.value;
	if(document.forms[0].cmdsave.disabled==false && document.forms[0].hidsecID.value=="" )
	{
	if(document.forms[0].hidstate.value=="")
	{
		alert("Please Reselect the City");
		document.forms[0].txt_addr_city.focus();
		return;
	}
	if(document.forms[0].txt_addr_city.value=="")
	{
		ShowAlert(112,"City");
		document.forms[0].txt_addr_city.focus();
		return;
	}	
	else		
	{
    var varQryString = appURL+"action/searchDistrict.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getDistrictSearch&statecode="+varstate+"&code="+val;
	var title = "District";
	var prop = 'scrollbars=yes,menubar=yes,status=yes,width=750,height=520';	
	prop = prop + ",left=200,top=200";
	window.open(varQryString,title,prop);
	}
	}	
	
}

function showtown(val)
{
  if(document.forms[0].cmdedit.disabled==true)
	{
	   if(document.forms[0].hidstate.value=="0")
		{ 
		 ShowAlert(111,'State');
		 document.forms[0].txt_addr_city.focus();
		 return;
		}
	   if(document.forms[0].hid_dist.value=="")
	    { 
		 ShowAlert(111,'District');
		 document.forms[0].txt_addr_district.focus();
		 return;
		  }
	  else
	   {
		document.forms[0].strdistId1.value=document.forms[0].hid_dist.value;
		var prop = "scrollbars=no,width=500,height=400,top=100,left=250";
		var url=appURL+"action/townmasterlist.jsp?&strdistId="+document.forms[0].strdistId1.value+"&hidBeanId=staticdata&hidBeanGetMethod=getTownMasterList&code="+val;
		window.open(url,"",prop);
	   }
	}   
}
function callLink(page,bean,method)
{ 
		if (document.forms[0].cmdsave.disabled)
		{
			document.forms[0].hidAction.value="";
		 	document.forms[0].hidBeanGetMethod.value=method;
		 	document.forms[0].hidBeanId.value=bean;
		 	document.forms[0].action=appURL+"action/"+page;
		 	document.forms[0].submit();
		}
		else 
		{
			ShowAlert(103);
		}
}	
function callMDTD()
{
	document.forms[0].action=appURL+"action/app_sec_MDTDdetails.jsp";
	document.forms[0].submit();	
}
function callLinkComments(page,bean,method,title)
{
	if (document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidAction.value="";
	 	document.forms[0].hidBeanGetMethod.value=method;
	 	document.forms[0].hidBeanId.value=bean;
	 	document.forms[0].hpage.value=title;	 
	 	document.forms[0].action=appURL+"action/"+page;
	 	document.forms[0].submit();
	}
	else 
	{
		ShowAlert(103);
	}
}
function callalert()
{
	alert("Click Freeze in Attached Securities page to view Security Coverage");
	return;
}


</script>
</head>
<body onload="onLoad();">
<form class="normal"  method="post">
 
 <%if(!Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ %>

<% if(strSessionModuleType.equalsIgnoreCase("DIGI")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkerdigi.jsp" flush="true"> 
        <jsp:param name="pageid" value="22" />
        </jsp:include>
		</td>
	</tr>
</table>
<% } else { %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="22" />
        </jsp:include>
		</td>
	</tr>
</table>
<%} %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
	 <%if(strSessionModuleType.equals("AGR")){%>
		<td class="page_flow">Home -&gt; Agriculture -&gt;Application -&gt; Security Master -&gt; Proposed/Offered Asset -&gt; House </td>
	<%}else if(strSessionModuleType.equals("DIGI")){%>
		<td class="page_flow">Home -&gt; Digi Retail -&gt; Application  -&gt; Security Master -&gt; Proposed/Offered Asset -&gt; House</td>
	<%}else{%>
		<td class="page_flow">Home -&gt; Retail(including schematic) -&gt; Application  -&gt; Security Master -&gt; Proposed/Offered Asset -&gt; House</td>
		<%} %>			
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr>
      <td>
        <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr align="center"> 
            <td align="center" width="15%" class="sub_tab_inactive"><b><b><a href="#" onclick="javascript:callLink('securitymaster_retail.jsp','bankappfi','getSecurityRetailDetails')">Borrower Securities</a></b></b>
            </td>
            <td align="center" width="15%" class="sub_tab_inactive"><b><b><a
					href="#" onclick="javascript:callLink('attachedsecurities_retail.jsp','bankappfi','getAttachedRetailSecurityDetails')">Attached Securities</a></b></b></td>
        
           <%if(strSessionModuleType.equals("RET") || strSessionModuleType.equals("DIGI") ){ %>
           
          	<%
				  if (prd_type.substring(0, 1).equalsIgnoreCase("p")
								&& !prd_type.equalsIgnoreCase("pE")
								&& !prd_type.equalsIgnoreCase("pG")
								&& !prd_type.equalsIgnoreCase("pM")
								&& !prd_type.equalsIgnoreCase("pL")
								&& !prd_type.equalsIgnoreCase("pI")) {
							if (linkid == 5) {
				%>
				<td class="sub_tab_active" WIDTH="15%" nowrap="nowrap"><b>Proposed/Offered
				Asset</b></td>
				<%
					} else if ((prd_type.equalsIgnoreCase("pH")&& !(strPrdPurpose.equalsIgnoreCase("F")||strPrdPurpose.equalsIgnoreCase("T")||strPrdPurpose.equalsIgnoreCase("HC")))
									|| prd_type.equalsIgnoreCase("pM")
									|| prd_type.equalsIgnoreCase("pI")
									|| prd_type.equalsIgnoreCase("pT")) {
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><a
					href="JavaScript:gototab('perpropertydetails','getHousingLoanData','per_house_proposed_asset.jsp')"><b>Proposed/Offered
				Asset</b></a></td>
				<%
					} else if (prd_type.equalsIgnoreCase("pA")||(prd_type.equalsIgnoreCase("pU") && strProAvailableFor.equalsIgnoreCase("V"))) {
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><a
					href="JavaScript:gototab('percollateral','getBoatAuto','perappvehicle.jsp')"><b>Proposed/Offered
				Asset</b></a></td>
				<%
					} else if (prd_type.equalsIgnoreCase("pD")) {
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><a
					href="JavaScript:gototab('perpropertydetails','getOtherAssetData','otherassets.jsp')"><b>Proposed/Offered
				Asset</b></a></td>
				<%
					} else if (prd_type.equalsIgnoreCase("pK")) {
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><a
					href="JavaScript:gototab('agreconomic','getSolarlightData','per_solarlight.jsp')"><b>Proposed/Offered
				Asset</b></a></td>
				<%
					}
						}	
         		 %>
          <% } %>
          
          <%
			if(strFreezeflag.equalsIgnoreCase("Y")){%>
		 	<td align="center" width="15%" class="sub_tab_inactive_new"><b>
		 	 	<a href="JavaScript:callLink('com_attchsecuritydisplay_reatail.jsp','securitymaster','getCollateralSecurityDisplayretail')">
			 	Security Coverage</a></b></td>				
			<% }else{%>
			<td align="center" width="15%" class="sub_tab_inactive_new" align="center"><b><a href="JavaScript:callalert()">Security Coverage</a></b></td>
			
				<%} %>
				
			<td align="center" width="15%" class="sub_tab_inactive"><b><b><a href="#" onclick="javascript:callLinkComments('per_commentsonseccovergae.jsp','facilities','getComments','secoverageretail')">Comments on Security Coverage</a></b></b></td>	
			<td align="center" width="15%" class="sub_tab_inactive"><b><b><a href="#" onclick="javascript:callMDTD()">MDTD</a></b></b></td>	
          
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0"
			align="left" class="outertable">
          <tr> 
            <td>
              <jsp:include page="../per/ProposedAssetTabs.jsp"
					flush="true"> 
              <jsp:param name="tabid" value="1" />
              </jsp:include>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
<%}else{%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="4" />
			<jsp:param name="subpageid" value="105" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr>
      <td>
        <table width="80%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr> 
             <td align="center" width="15%" class="sub_tab_inactive"><b><b><a href="#" onclick="javascript:callLink('securitymaster_retail.jsp','bankappfi','getSecurityRetailDetails')">Security</a></b></b>
            </td>
            <td align="center" width="15%" class="sub_tab_inactive"><b><b><a
					href="#" onclick="javascript:callLink('attachedsecurities_retail.jsp','bankappfi','getAttachedRetailSecurityDetails')">Attached Securities</a></b></b></td>
			 <td align="center" width="15%" class="sub_tab_active"><b>Proposed/Offered
Asset</b></td>
          <%
			if(strFreezeflag.equalsIgnoreCase("Y")){%>
		 	<td align="center" width="15%" class="sub_tab_inactive"><b>
		 	 	<a href="JavaScript:callLink('com_attchsecuritydisplay_reatail.jsp','securitymaster','getCollateralSecurityDisplayretail')">
			 	Security Coverage</a></b></td>				
			<% }else{%>
			<td align="center" width="15%" class="sub_tab_inactive" align="center"><b><a href="JavaScript:callalert()">Security Coverage</a></b></td>
			
				<%} %>
				
          
          </tr>
        </table>
      </td>
    </tr>
  </table>
 <%} %>
   
  
  <br>
  <table width="98%" align="center" cellspacing="0" cellpadding="0"
	class="outertable">
    <tr> 
      <td> 
        <table width="100%" cellspacing="0" cellpadding="5"
			class="outertable linebor">
          <tr> 
            <td>Purpose of Loan <span class="mantatory">*</span></td>
            <td>
              <select name="sel_purpose_of_loan" onchange="hideFields()">
                <option value="0" selected="selected">--Select--</option>
                <option value="G">Purchase of Site</option>
                <option value="C">Construction of House</option>
                <option value="S">Purchase of Site & Construction of House</option>
                <option value="H">Purchase of Ready Built House/Flat</option>
                <option value="R">Renovation</option>
                <option value="M">Mortgage</option>
              </select>
            </td>
            <td>Whether Take-Over <span class="mantatory">*</span></td>
            <td>
              <select name="sel_take_over">
                <option value="0" selected="selected">--Select--</option>
                <option value="Y">Yes</option>
                <option value="N">No</option>
              </select>
            </td>
          </tr>
          <tr> 
            <td id="mand">Type of Property <span class="mantatory">*</span></td>
            <td id="notmand">Type of Property</td>
            <td>
              <select name="sel_property_type" onchange="hideFields()">
                <option value="0" selected="selected">--Select--</option>
                <option value="L">Land</option>
                <option value="F">Flat / Apartment</option>
                <option value="H">House / Building</option>
              </select>
            </td>
            <td>Nature of Property</td>
            <td>
              <select name="sel_property_nature">
                <option value="0" selected="selected">--Select--</option>
                <option value="R">Residential</option>
                <option value="C">Commercial</option>
              </select>
            </td>
          </tr>
          <tr> 
            <td>Property used for</td>
            <td>
              <select name="txt_property_for">
                <option value="0" selected="selected">--Select--</option>
                <option value="R">Renting Out</option>
                <option value="O">Self Occupation</option>
                <option value="L">Leasing Out</option>
                <option value="C">Commercial</option>
              </select>
            </td>
             <td>Distance from Branch <span class="mantatory">*</span></td>
            <td>
              <input type="text" name="txt_branch_distance" maxlength="3"
					size="10" onkeypress="allowInteger()"
					value="<%=Helper.correctNull((String) hshValues
							.get("phpa_branch_distance"))%>">
               Kms</td>
          </tr>
          <tr> 
            <td id="Residual">Residual Life of Premises<span class="mantatory">*</span></td>
            <td id="Residual1">
              <input type="text" name="txt_residual_life" maxlength="3" onblur="checkResidualLife()"
					size="10" onkeypress="allowInteger()"
					value="<%=Helper.correctNull((String) hshValues
							.get("phpa_residual_life"))%>">
                Years</td>
              
               <td id="idage">Age of the Premises<span class="mantatory">*</span></td>
            <td id="idage2">
              <input type="text" name="txt_premises_age" maxlength="3" onblur="checkAgePremises()"
					size="10" onkeypress="allowInteger()"
					value="<%=Helper.correctNull((String) hshValues.get("phpa_premises_age"))%>" >
            </td>
          </tr>
          
          <tr> 
            <td>Security Type <span class="mantatory">*</span></td>
            <td>
              <select name="sel_securitytype" onChange="callSecurityType()">
               <option value="0">&lt;--Select--&gt;</option>
               <lapschoice:SchemeSecuritiesTag parenttype="0" schemecode="H"/>
						</select>
            </td>
            <td>Security Classification <span class="mantatory">*</span></td>
            <td>

               <select name="sel_securityclassifcation">
                      <option selected value="0">--Select--</option>
                    </select></td>
          </tr>
          <tr>
			<td>Nature of Charge <span class="mantatory">*</span></td>
			<td> 
              <select name="sel_natureCharge" tabindex="" >
				<option value="0" selected> --Select-- </option>
                <lapschoice:StaticDataNewTag apptype="134"  /> 
			 </select>
			</td>
			<td>Type of house<span class="mantatory">*</span></td>
            <td>
              <select name="sel_house_type">
                <option value="" selected="selected">--Select--</option>
                <option value="01">New</option>
                <option value="02">Re-purchased</option>
                <option value="03">Existing</option>
              </select>
            </td>
		</tr>
          
          <tr id="id_mortgage_already"> 
            <td>Whether Property Already Mortgaged?<span class="mantatory">*</span></td>
            <td>
              <select name="sel_already_mortgaged">
                <option value="0" selected="selected">--Select--</option>
                <option value="Y">Yes</option>
                <option value="N">No</option>
              </select>
            </td>
            <td colspan="2">&nbsp;</td>
          </tr>
          <tr class="dataHeader"> 
            <td colspan="4"><b>Location Parameters</b></td>
          </tr>
          <tr> 
            <td>Location of Property <span class="mantatory">*</span></td>
            <td>
              <select name="sel_property_location">
                <option value="0" selected="selected">--Select--</option>
                <option value="M">Metro</option>
                <option value="U">Urban</option>
                <option value="S">Semi-Urban</option>
                <option value="R">Rural</option>
              </select>
            </td>
            <td>Survey No. <span class="mantatory">*</span></td>
            <td>
              <input type="text" name="txt_survey_no" maxlength="16"
					size="20" onkeypress="allowAlphabetsAndSpaceInt(this)"
					value="<%=Helper.correctNull((String) hshValues
							.get("phpa_prop_surveyno"))%>">
            </td>
          </tr>
          <tr> 
            <td>House/Plot No. <span class="mantatory">*</span></td>
            <td>
              <input type="text" name="txt_plot_no" maxlength="10"
					size="10" onkeypress="allowAlphabetsAndSpaceInt(this)"
					value="<%=Helper.correctNull((String) hshValues
							.get("phpa_prop_plotno"))%>">
            </td>
            <td>Street <span class="mantatory">*</span></td>
            <td>
              <input type="text" name="txt_addr_street" maxlength="45"
					size="45" onkeypress="allowAlphabetsAndSpaceInt(this)"
					value="<%=Helper.correctNull((String) hshValues
							.get("phpa_prop_street"))%>">
            </td>
          </tr>
          <tr> 
            <td>Taluk <span class="mantatory">*</span></td>
            <td>
              <input type="text" name="txt_addr_taluk" maxlength="45"
					size="45" onkeypress="allowAlphabetsAndSpaceInt(this)"
					value="<%=Helper.correctNull((String) hshValues
							.get("phpa_prop_taluk"))%>">
            </td>
            <td>City <span class="mantatory">*</span></td>
            <td>
              <input type="text" name="txt_addr_city" maxlength="45" size="45" onkeypress="allowAlphabetsForName()"
					value="<%=Helper.correctNull((String) hshValues.get("phpa_prop_city"))%>">
					<a id="City_pop" href="#" onClick="showCitySearch1('txt_addr_city','txt_addr_state','hidcity','hidstate','txt_addr_pincode','hidres1');"
					style="cursor:hand" tabindex="22"><img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" tabindex="21"></a>
			 <input type="hidden" name="hidcity" size="5" value="<%=Helper.correctNull((String)hshValues.get("phpa_prop_citycode"))%>">				
			</td>
          </tr>
          <tr> 
            <td>District <span class="mantatory">*</span></td>
            <td>
              <input type="text" name="txt_addr_district" maxlength="45" size="45" onkeypress="allowAlphabetsForName()"
					value="<%=Helper.correctNull((String) hshValues.get("phpa_prop_district"))%>">
					 <a id="Dist_pop" href="#" onClick="showDistSearch('perhou');" style="cursor:hand" tabindex="22">
					<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" tabindex="21"></a>
			<input type="hidden" name="hid_dist" size="5" value="<%=Helper.correctNull((String)hshValues.get("phpa_prop_districtcode"))%>">				
            </td>
            <td>State <span class="mantatory">*</span></td>
            <td>
              <input type="text" name="txt_addr_state" maxlength="45" size="45" onkeypress="allowAlphabetsForName()"
					value="<%=Helper.correctNull((String) hshValues.get("phpa_prop_state"))%>">
			<input type="hidden" name="hidstate" value="<%=Helper.correctNull((String) hshValues.get("phpa_prop_statecode"))%>" />
            </td>
            
          </tr>
          <tr> 
            <td>Town <%if(Helper.correctNull((String)hshValues.get("govt_scheme")).equalsIgnoreCase("078")||Helper.correctNull((String)hshValues.get("govt_scheme")).equalsIgnoreCase("079")){ %><span class="mantatory">*</span><%} %></td>
            <td>
              <input type="text" name="txt_addr_town" maxlength="45" size="45" onkeypress="allowAlphabetsForName()"
					value="<%=Helper.correctNull((String) hshValues.get("phpa_town_desc"))%>">
				<b><span id="Town_pop" onClick="javascript:showtown('per_house')" style="cursor: hand"> 
					<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0"> 
					</span>
				</b>
			  <input type="hidden" name="hidtown" value="<%=Helper.correctNull((String) hshValues.get("phpa_hidtown"))%>" />
            </td>
             <td>Pincode <span class="mantatory">*</span></td>
            <td>
              <input type="text" name="txt_addr_pincode" maxlength="6"
					size="10" onkeypress="allowInteger()" onBlur="zipvalidate(this,6)"
					value="<%=Helper.correctNull((String) hshValues
							.get("phpa_prop_pincode"))%>">
            </td>
          </tr>
          <tr class="dataHeader"> 
            <td colspan="4"><b>Area Specifications</b></td>
          </tr>
          <tr> 
            <td id="id_sitearea_lbl">Area of Site <span
					class="mantatory">*</span></td>
            <td id="id_sitearea_val">
              <input type="text"
					name="txt_area_site" maxlength="15" size="20"
					onkeypress="allowDecimals(this)" onblur="roundtxt(this)"
					value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("phpa_site_area"))))%>" style="text-align:right">
               Sq.Ft.</td>
            <td id="id_builtuparea_lbl">Floor Space/Builtup Area <span
					class="mantatory">*</span></td>
            <td id="id_builtuparea_val">
              <input type="text"
					name="txt_area_floorspace" maxlength="15" size="20"
					onkeypress="allowDecimals(this)" onblur="roundtxt(this)"
					value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("phpa_floorspace_area"))))%>" style="text-align:right">
               Sq.Ft.</td>
          </tr>
          <tr class="dataHeader"> 
            <td colspan="4"><b>Cost Specifications</b></td>
          </tr>
          <tr id="id_sitevalue_row"> 
            <td>Market Value of Plot <span class="mantatory">*</span></td>
            <td>
              <input type="text" name="txt_marketvalue_site"
					maxlength="15" size="20" onkeypress="allowDecimals(this)"
					onblur="roundtxt(this)"
					value="<%=Helper.checkDecimal(Helper.correctDouble((String) hshValues.get("phpa_site_market_value")))%>" style="text-align:right">
              (Rs.)</td>
            <td>Purchase Value of Plot <span class="mantatory">*</span></td>
            <td>
              <input type="text" name="txt_purchasevalue_site"
					maxlength="15" size="20" onkeypress="allowDecimals(this)"
					onblur="roundtxt(this)"
					value="<%=Helper.checkDecimal(Helper.correctDouble((String) hshValues.get("phpa_site_purchase_price")))%>" style="text-align:right">
              (Rs.)</td>
          </tr>
          <tr id="id_bldgvalue_row"> 
            <td>Market Value of Building/Flat <span class="mantatory">*</span></td>
            <td>
              <input type="text" name="txt_marketvalue_flat"
					maxlength="15" size="20" onkeypress="allowDecimals(this)"
					onblur="roundtxt(this)"
					value="<%=Helper.checkDecimal(Helper.correctDouble((String) hshValues.get("phpa_bldg_market_value")))%>" style="text-align:right">
              (Rs.)</td>
            <td>Purchase Value of Building/Flat <span
					class="mantatory">*</span></td>
            <td>
              <input type="text" name="txt_purchasevalue_flat"
					maxlength="15" size="20" onkeypress="allowDecimals(this)"
					onblur="roundtxt(this)"
					value="<%=Helper.checkDecimal(Helper.correctDouble((String) hshValues.get("phpa_bldg_purchase_price")))%>" style="text-align:right">
               (Rs.)</td>
          </tr>
          <tr id="id_renovation_row" style="visibility: hidden;position: absolute;"> 
            <td>Cost of Renovation/Construction</td>
            <td>
              <input type="text" name="txt_cost_renovation"
					maxlength="15" size="20" onkeypress="allowDecimals(this)"
					onblur="roundtxt(this);totalval()" readOnly
					value="<%=Helper.checkDecimal(Helper.correctDouble((String) hshValues.get("phpa_constucion_cost")))%>" style="text-align:right">
              (Rs.)</td>
            <td>Market value of the Property<span
					class="mantatory">*</span></td>
            <td>
              <input type="text" name="txt_marketVal"
					maxlength="15" size="20" onkeypress="allowDecimals(this)"
					onblur="roundtxt(this);totalval()"
					value="<%=Helper.checkDecimal(Helper.correctDouble((String) hshValues.get("phpa_bldg_market_value")))%>" style="text-align:right">
               (Rs.)</td>
          </tr>
          <tr>
          <td  style="border: none;">One time Single Premium for Met Loan &amp; Life Suraksha</td>
          <td  style="border: none;">
          <input type="text" name="txt_metloanpremium" maxlength="15" size="20"
					onkeypress="allowDecimals(this)" onblur="roundtxt(this)"
					value="<%=Helper.checkDecimal(Helper.correctDouble((String) hshValues.get("phpa_metlifepremiumamt")))%>" style="text-align:right">
          </td>
          </tr>
          <tr> 
            <td id="id_conscost_lbl"style="border: none;">Estimated Cost of Construction <span
					class="mantatory">*</span></td>
            <td id="id_conscost_val"style="border: none;">
              <input type="text"
					name="txt_construction_estimate" maxlength="15" size="20"
					onkeypress="allowDecimals(this)" onblur="roundtxt(this)"
					value="<%=Helper.checkDecimal(Helper.correctDouble((String) hshValues.get("phpa_bldg_estimate_cost")))%>" style="text-align:right">
               (Rs.)</td>
            <td id="id_rennovation_lbl" style="border: none;">Total Cost</td>
            <td id="id_rennovation_val" style="border: none;">
              <input type="text"
					name="txt_rennovation_bldg" maxlength="15" size="20"
					onkeypress="allowDecimals(this)" onblur="roundtxt(this)" readOnly
					value="<%=Helper.checkDecimal(Helper.correctDouble((String) hshValues.get("phpa_bldg_rennovation_cost")))%>" style="text-align:right">
                (Rs.)</td>
          </tr>
          <tr> 
            <td id="id_sitevalprice_lbl" style="border: none;">Forced sale value of Plot <span	
            
					class="mantatory">*</span></td>
            <td id="id_sitevalprice_val" style="border: none;">
              <input type="text"
					name="txt_valuation_site" maxlength="15" size="20"
					onkeypress="allowDecimals(this)" onblur="roundtxt(this)" 
					value="<%=Helper.checkDecimal(Helper.correctDouble((String) hshValues.get("phpa_site_valuation_cost")))%>" style="text-align:right">
               (Rs.)</td>
            <td id="id_bldgvalprice_lbl" style="border: none;">Forced sale value of Building/Flat<span class="mantatory">*</span></td>
            <td id="id_bldgvalprice_val" style="border: none;">
              <input type="text"
					name="txt_valuation_flat" maxlength="15" size="20"
					onkeypress="allowDecimals(this)" onblur="roundtxt(this)"
					value="<%=Helper.correctDouble((String) hshValues
							.get("phpa_bldg_valuation_cost"))%>" style="text-align:right">
               (Rs.)</td>
          </tr>
          <tr class="dataHeader" id="id_projdet_header"> 
            <td colspan="4"><b>Project Details</b></td>
          </tr>
          <tr id="id_projdet_row1"> 
            <td>Project Name <span class="mantatory">*</span></td>
            <td>
              <input type="text" name="txt_project_name" maxlength="45"
					size="45" onkeypress="allowAlphabetsAndSpaceInt(this)"
					value="<%=Helper.correctNull((String) hshValues
							.get("phpa_project_name"))%>">
            </td>
            <td>Builder Name</td>
            <td>
              <input type="text" name="txt_builder_name" maxlength="45"
					size="45" onkeypress="allowAlphabetsAndSpaceInt(this)"
					value="<%=Helper.correctNull((String) hshValues
							.get("phpa_builder_name"))%>">
            </td>
          </tr>
          <tr id="id_projdet_row2"> 
            <td>Project Details</td>
            <td>
              <textarea name="txtar_project_details" rows="7" cols="40"
					onkeydown="textlimit(this,400);checkEnter();" onKeyPress="textlimit(this,399)" onkeyup="textlimit(this,399)"><%=Helper.correctNull((String) hshValues.get("phpa_project_details"))%></textarea>
            </td>
            <td>Background of Builder</td>
            <td>
              <textarea name="txtar_builder_background" rows="7"
					cols="40" onkeydown="textlimit(this,400);checkEnter();"
					onKeyPress="textlimit(this,399)" onkeyup="textlimit(this,399)"><%=Helper.correctNull((String) hshValues.get("phpa_builder_background"))%></textarea>
            </td>
          </tr>
          <tr id="id_projdet_row3"> 
            <td>Whether the project finance is sanctioned in our bank <span
					class="mantatory">*</span></td>
            <td>
              <select name="sel_projfin_sanc">
                <option value="0" selected="selected">--Select--</option>
                <option value="Y">Yes</option>
                <option value="N">No</option>
              </select>
            </td>
          </tr>
          <tr class="dataHeader"> 
            <td colspan="4"><b>Location / Amenities Details</b></td>
          </tr>
          <tr> 
            <td vAlign=top>Location [Indicators]</td>
            <td> 
              <table cellSpacing="0" cellPadding="3" width="100%" border="0"
					class="outertable">
                <tbody> 
                <tr> 
                <td>Near by Main Road <span class="mantatory">&nbsp;*</span></td>
                  <td>
                  <select name="chk_mainroad">
                  <option value=""><--select--></option>
                  <option value="Y">Yes</option>
                  <option value="N">No</option>
                  </select>
                  </td>
                </tr>
                <tr> 
                <td>Near by Market/ Educational Institution<span class="mantatory">&nbsp;*</span></td>
                  <td>
                  <select name="chk_eduinstitution">
                  <option value=""><--select--></option>
                  <option value="Y">Yes</option>
                  <option value="N">No</option>
                  </select>
                  </td>
                </tr>
                <tr> 
                <td>Near by Other Public Utilities <br>
                    viz., Hospital/Post Office/Railway Station etc<span class="mantatory">&nbsp;*</span></td>
                  <td>
                  <select name="chk_public">
                  <option value=""><--select--></option>
                  <option value="Y">Yes</option>
                  <option value="N">No</option>
                  </select>
                  </td>
                </tr>
                <tr> 
                <td>Neighbourhood - Prime/ Suburb etc.<span class="mantatory">&nbsp;*</span></td>
                  <td>
                  <select name="chk_prime">
                  <option value=""><--select--></option>
                  <option value="Y">Yes</option>
                  <option value="N">No</option>
                  </select>
                  </td>
                </tr>
                </tbody> 
              </table>
            </td>
            <td vAlign=top>Amenities [Indicators]</td>
            <td> 
              <table cellSpacing="0" cellPadding="3" width="100%" border="0"
					class="outertable">
                <tbody> 
                <tr> 
                <td>Accessible to Road<span class="mantatory">&nbsp;*</span></td>
                  <td>
                  <select name="chk_accessible">
                  <option value=""><--select--></option>
                  <option value="Y">Yes</option>
                  <option value="N">No</option>
                  </select>
                  </td>
                </tr>
                <tr> 
                <td>Assured water supply<span class="mantatory">&nbsp;*</span></td>
                  <td>
                  <select name="chk_assured">
                  <option value=""><--select--></option>
                  <option value="Y">Yes</option>
                  <option value="N">No</option>
                  </select>
                  </td>
                </tr>
                <tr> 
                <td>Proper Drainage System/ Not pruned to water logging<span class="mantatory">&nbsp;*</span></td>
                  <td>
                  <select name="chk_drainages">
                  <option value=""><--select--></option>
                  <option value="Y">Yes</option>
                  <option value="N">No</option>
                  </select>
                  </td>
                </tr>
                <tr> 
                <td>Current Connection available<span class="mantatory">&nbsp;*</span></td>
                  <td>
                  <select name="chk_currentconnection">
                  <option value=""><--select--></option>
                  <option value="Y">Yes</option>
                  <option value="N">No</option>
                  </select>
                  </td>
                </tr>
                </tbody> 
              </table>
            </td>
          </tr> 
        </table>
      </td>
    </tr>
  </table>
  <br>
  <table border="0" cellspacing="0" cellpadding="3" align="center"
	class="outertable linebor buttonbgcolor">
    <tr> 
      <td align="center">
        <input type="button" name="cmddisbursement"
			value="Disbursement details" class="buttonStyle" style="width: 150"
			onClick="opendisbursement()">
      </td>
      <td align="center">
        <input type="button" name="cmddisbursement2"
			value="General Information" class="buttonStyle" style="width: 150"
			onClick="openGeneral()">
      </td>
       
      <%if(strTakeOver_app.equals("Y")) {%>
      <td align="center">
        <input type="button" name="pretakeover"
			class="buttonStyle" style="width: 150" value="TakeOver"
			onClick="calltakeover()">
      </td>
      <%} %>
    </tr>
  </table>
  <br>
  <lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail'
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
	
	
	 <table width="98%" align="center" cellspacing="0" cellpadding="0"
	class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="1" cellpadding="0"
					class="outertable">
					<tr class="dataheader">
						<td width="5%">&nbsp;</td>
						<td width="5%" align="center" nowrap="nowrap"><b>Sno</b></td>
						<td width="20%" align="center" nowrap="nowrap"><b>Purpose of Loan </b></td>
						<td width="20%" align="center" nowrap="nowrap"><b>Security Type</b></td>
						<td width="20%" align="center" nowrap="nowrap"><b>Area of Site </b></td>
						<td width="15%" align="center" nowrap="nowrap"><b>Market Value of Plot</b></td>
						<td width="15%" align="center" nowrap="nowrap"><b>Security ID</b></td>
					</tr>
				</table>
				</td>
			</tr>

			<tr>
				<td>

				<table width="100%" border="0" cellspacing="1" cellpadding="0" class="outertable" >
					<%ArrayList g1 = new ArrayList();
					ArrayList v = (ArrayList) hshValues.get("vecRow");
					if (v != null) {
					int vecsize = v.size();
					for (int l = 0; l < vecsize; l++) {
					g1 = (ArrayList) v.get(l);

					%>
					<tr valign="top" class="datagrid">
						<td width="5%"><input type="radio"
							onclick="javascript:getSelectedValue('<%=Helper.correctNull((String)g1.get(0))%>','<%=Helper.correctNull((String)g1.get(1))%>',
																		 '<%=Helper.correctNull((String)g1.get(2))%>','<%=Helper.correctNull((String)g1.get(3))%>',
																		 '<%=Helper.correctNull((String)g1.get(4))%>','<%=Helper.correctNull((String)g1.get(5))%>',
																		 '<%=Helper.correctNull((String)g1.get(6))%>','<%=Helper.correctNull((String)g1.get(7))%>',
																		 '<%=Helper.correctNull((String)g1.get(8))%>','<%=Helper.correctNull((String)g1.get(9))%>',
																		 '<%=Helper.correctNull((String)g1.get(10))%>','<%=Helper.correctNull((String)g1.get(11))%>',
																		 '<%=Helper.correctNull((String)g1.get(12))%>','<%=Helper.correctNull((String)g1.get(13))%>',
																		 '<%=Helper.correctNull((String)g1.get(14))%>','<%=Helper.correctNull((String)g1.get(15))%>',
																		 '<%=Helper.correctNull((String)g1.get(16))%>','<%=Helper.correctNull((String)g1.get(17))%>',
																		  '<%=Helper.correctNull((String)g1.get(18))%>','<%=Helper.correctNull((String)g1.get(19))%>',
																		 '<%=Helper.correctNull((String)g1.get(20))%>','<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)g1.get(21))))%>',
																		 '<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)g1.get(22))))%>','<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)g1.get(23))))%>',
																		 '<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)g1.get(24))))%>','<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)g1.get(25))))%>',
																		 '<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)g1.get(26))))%>','<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)g1.get(27))))%>',
																		 '<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)g1.get(28))))%>','<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)g1.get(29))))%>',
																		 '<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)g1.get(30))))%>','<%=Helper.correctNull((String)g1.get(31))%>',
																		  '<%=Helper.correctNull((String)g1.get(32))%>','<%=Helper.correctNull((String)g1.get(33))%>',
																		 '<%=Helper.correctNull((String)g1.get(34))%>','<%=Helper.correctNull((String)g1.get(35))%>',
																		 '<%=Helper.correctNull((String)g1.get(36))%>','<%=Helper.correctNull((String)g1.get(37))%>',
																		 '<%=Helper.correctNull((String)g1.get(38))%>','<%=Helper.correctNull((String)g1.get(39))%>',
																		 '<%=Helper.correctNull((String)g1.get(40))%>','<%=Helper.correctNull((String)g1.get(41))%>',
																		 '<%=Helper.correctNull((String)g1.get(42))%>','<%=Helper.correctNull((String)g1.get(43))%>',
																		 '<%=Helper.correctNull((String)g1.get(44))%>','<%=Helper.correctNull((String)g1.get(45))%>',
																		 '<%=Helper.correctNull((String)g1.get(46))%>','<%=Helper.correctNull((String)g1.get(47))%>',
																		 '<%=Helper.correctNull((String)g1.get(48))%>','<%=Helper.correctNull((String)g1.get(49))%>',
																		 '<%=Helper.correctNull((String)g1.get(50))%>','<%=Helper.correctNull((String)g1.get(51))%>',
																		 '<%=Helper.correctNull((String)g1.get(52))%>','<%=Helper.correctNull((String)g1.get(53))%>',
																		 '<%=Helper.correctNull((String)g1.get(54))%>','<%=Helper.correctNull((String)g1.get(55))%>',
																		 '<%=Helper.correctNull((String)g1.get(56))%>','<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)g1.get(57))))%>',
																		 '<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)g1.get(58))))%>',
																		 '<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)g1.get(59))))%>')"
							name="radiobutton"
							value="<%=Helper.correctNull((String) g1.get(1))%>"
							style="border: none"> &nbsp;</td>
							<td width="5%"><%=Helper.correctNull((String) g1.get(52))%></td>
						<td width="20%" align="center"><%=Helper.correctNull((String) g1.get(55))%></td>
						<td width="20%" align="center"><%=Helper.correctNull((String) g1.get(54))%></td>
						<td width="20%"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)g1.get(21))))%></td>
						<td width="15%"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)g1.get(23))))%>&nbsp;</td>
						<td width="15%"><%=Helper.correctNull((String) g1.get(53))%></td>
					</tr>
					<%
														}
													}
												%>


					<tr class="datagrid">
						<td align="center" width="5%" colspan="7">&nbsp;</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>	
				
	<input type="hidden" name="hidSecurityId" value="<%=Helper.correctNull((String) hshValues.get("strSecId"))%>">	
	<input type="hidden" name="hidOwners"> 					
	<input type="hidden" name="hidSecValue" value="<%=Helper.correctNull((String) hshValues.get("cus_sec_joint_holder"))%>"> 	
	<input type="hidden" name="hidJointOwnValue" value="<%=Helper.correctNull((String) hshValues.get("strJointOwnDetails"))%>">
	<input type="hidden" name="hidDeleteOwn" value="0"> 	
	<input type="hidden" name="strdistId1" value="">
	<input type="hidden" name="hidres1" value="">
	<input type="hidden" name="old_sel_securityclassifcationText" value="">
	<input type="hidden" name="hidsnmbr" value="">	
	<input type="hidden" name="hidsecID" value="">	
  	<input type="hidden" name="hpage">
	<input type="hidden" name="hidsecClass" value="">
	<input type="hidden" name="hidValuationFlag" value="<%=Helper.correctNull((String)hshValues.get("valuationFlag"))%>">
	<input type="hidden" name="hidHouseEdit_Flag" value="<%=Helper.correctNull((String)hshValues.get("HouseEdit_Flag"))%>">
	<input type="hidden" name="hidVehicleEdit_Flag" value="<%=Helper.correctNull((String)hshValues.get("VehicleEdit_Flag"))%>">
	<lapschoice:hiddentag pageid="<%=PageId%>" />	
<input type="hidden" name="hidPSparams" value="<%=Helper.correctNull((String)session.getAttribute("strModifyterms")) %>">
  <iframe	height="0" width="0" id="ifrmsecurityclassification" frameborder=0 style="border: 0">	
</form>
</body>
</html>