<%@include file="../share/directives.jsp"%>
<%
	String strappno = Helper.correctNull((String) hshValues
			.get("SOL_APPL_NO"));
	session.setAttribute("strappno", strappno);
	String strappstatus = Helper.correctNull((String) hshValues
			.get("SOL_STATUS"));
	session.setAttribute("strappstatus", strappstatus);
	String appno = Helper.correctNull((String) hshValues
			.get("strappno"));
	String strBtnenable = Helper.correctNull((String) hshValues
			.get("btnenable"));
	session.setAttribute("strBtnenable", strBtnenable);
	String strCertificateNo=Helper.correctNull((String) hshValues.get("SOL_CERTF_NO"));
	String[] strCertNo=strCertificateNo.split("/");
	String strSanBranch=Helper.correctNull((String) hshValues.get("SOL_SANCTIONING_BRANCH"));
%>
<html>
<head>
<title>Proposal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script type="text/javascript">
	var sanctionedby = "<%=Helper.correctNull((String) hshValues.get("SOL_SANCTIONED_BY"))%>";
	var appno="<%=Helper.correctNull((String) hshValues.get("SOL_APPL_NO"))%>";
    var id="<%=Helper.correctNull((String) hshValues.get("SOL_APPID"))%>";
    var varappholder='<%=Helper.correctNull((String) hshValues
							.get("SOL_APPLNHOLDER"))%>'; 
    var varAction="<%=Helper.correctNull((String) hshValues.get("hidAction"))%>";
    var curDate="<%=Helper.getCurrentDateTime()%>";
    var varsanbranch="<%=strSanBranch%>";
	var appraisal_department = "<%=Helper.correctNull((String) hshValues.get("SOL_SANCTIONING_DEPT"))%>";
    
     function onloading() 
    {
		disabledFields(true);
		if (sanctionedby != "")
		 {
			document.forms[0].sel_SancAuth.value = sanctionedby;
		 }
		if (appraisal_department != "")
		 {		
			document.forms[0].sel_SancDept.value=appraisal_department;
		 }
		funsanctiondept(sanctionedby);
		funsancrefno();
		if(varsanbranch!="")
		{
			document.forms[0].sel_SancBranch.value =varsanbranch;
		}
		 if(document.forms[0].btnenable.value=="Y")
		 {
	    	<%if (strappstatus.equalsIgnoreCase("PR")
					|| strappstatus.equalsIgnoreCase("PA")) {%>
	    		enableButtons(true, true, true, false, false);
	     
	   		 <%} else {%>
	        enableButtons(false, true, true, true, false);
	    	<%}%>
		 }
		 if(varAction=="new")
   		 {
	   			enableButtons(true, false, true, true, false);
	   			document.forms[0].hidAction.value = "new";
	   			document.forms[0].txt_issuedt.value = curDate;
	   			disabledFields(false);
	   	 }
		    document.forms[0].txt_cbsid.readOnly = true;
			document.forms[0].txt_nameofappl.readOnly = true;
			document.forms[0].txt_address.readOnly = true;
			document.forms[0].txt_addresstwo.readOnly = true;
			document.forms[0].txt_village.readOnly = true;
			document.forms[0].txt_city.readOnly = true;
			document.forms[0].txt_district.readOnly = true;
			document.forms[0].txt_state.readOnly = true;
			document.forms[0].txt_permzip.readOnly = true;
			document.forms[0].txtperapp_country.readOnly = true; 
			document.forms[0].txt_solcertf.readOnly = true;
			document.forms[0].hid_appid.readOnly = true;
			document.forms[0].txt_applno.readOnly = true;
			document.forms[0].txt_networth.readOnly = true;
			document.forms[0].old_appid.readOnly = true;
			document.forms[0].txt_issuedt.readOnly = true;
	 }
	 
	function callCalender(name) {
		if (document.forms[0].cmdsave.disabled == false) {
			showCal(appURL, name);
		}
	}
	
	function enableButtons(bool1, bool2, bool3, bool4, bool5) {
		document.forms[0].cmdedit.disabled = bool1;
		document.forms[0].cmdsave.disabled = bool2;
		document.forms[0].cmdcancel.disabled = bool3;
		document.forms[0].cmddelete.disabled = bool4;
		document.forms[0].cmdclose.disabled = bool5;
	}

	function doCancel() {
		if (ConfirmMsg(102)) {
			document.forms[0].hidBeanId.value = "comsolvency";
			document.forms[0].hidBeanGetMethod.value = "getSolvencyData";
			document.forms[0].action = appURL + "action/com_solvency.jsp";
			document.forms[0].submit();
		}
	}

	 function doEdit() {
		 
		disabledFields(false);
		document.forms[0].hidAction.value = "insert";
		enableButtons(true, false, false, false, false);
		document.forms[0].txt_cbsid.readOnly = true;
		document.forms[0].txt_nameofappl.readOnly = true;
		document.forms[0].txt_address.readOnly = true;
		document.forms[0].txt_addresstwo.readOnly = true;
		document.forms[0].txt_village.readOnly = true;
		document.forms[0].txt_city.readOnly = true;
		document.forms[0].txt_district.readOnly = true;
		document.forms[0].txt_state.readOnly = true;
		document.forms[0].txt_permzip.readOnly = true;
		document.forms[0].txtperapp_country.readOnly = true; 
		document.forms[0].txt_solcertf.readOnly = true;
		document.forms[0].txt_solcertf2.readOnly = true;
		document.forms[0].hid_appid.readOnly = true;
		document.forms[0].txt_applno.readOnly = true;
		document.forms[0].txt_networth.readOnly = true;
		document.forms[0].old_appid.readOnly = true;
		document.forms[0].txt_issuedt.readOnly = true;
		document.forms[0].txt_commissionearn.readOnly = true;
		
	}

	function doDelete() 
	{
		if (ConfirmMsg(101)) 
		{
			document.forms[0].hidAction.value = "delete";
			document.forms[0].action = appURL + "action/ControllerServlet";
			document.forms[0].hidBeanId.value = "comsolvency";
			document.forms[0].hidBeanMethod.value = "updateSolvencyData";
			document.forms[0].hidBeanGetMethod.value = "getSolvencyData";
			document.forms[0].hidSourceUrl.value = "action/com_solvency.jsp";
			document.forms[0].submit();

			alert("Application Deleted Sucessfully");
			document.forms[0].hidSourceUrl.value = "action/com_searchsolvency.jsp";
			document.forms[0].submit();
        }
	}

	function doClose() 
	{
		if (ConfirmMsg(100)) 
		{
			document.forms[0].action = appURL + "action/mainnav.jsp";
			document.forms[0].submit();
		}
	}

	function doSave() 
	{
		if (document.forms[0].txt_nameofappl.value == "") {
			ShowAlert('121', "Name of The Applicant");
			document.forms[0].txt_nameofappl.focus();
			return;
		}
		if (document.forms[0].txt_address.value == "") {
			ShowAlert('121', "Address");
			document.forms[0].txt_address.focus();
			return;
		}
		if (document.forms[0].txt_purpose.value == "") {
			ShowAlert('121', "Purpose");
			document.forms[0].txt_purpose.focus();
			return;
		}
		if (document.forms[0].txt_amtrs.value == "") {
			ShowAlert('121', "Amount[In Rs.]");
			document.forms[0].txt_amtrs.focus();
			return;
		}
		if (document.forms[0].txt_commissionearn.value == "") {
			ShowAlert('121', "Commission Earned[In Rs.]");
			document.forms[0].txt_commissionearn.focus();
			return;
		}
		if (document.forms[0].txt_networth.value == "") {
			ShowAlert('121', "Net Worth[In Rs.]");
			document.forms[0].txt_networth.focus();
			return;
		}
		if (document.forms[0].txt_city.value == "") {
			ShowAlert('121', "City");
			document.forms[0].txt_city.focus();
			return;
		}
		if(document.forms[0].sel_SancDept.value=="s")
		{
			ShowAlert('111', "Sanctioning Department"); 	
			document.forms[0].sel_SancDept.focus();
			return;	
		}
		if((document.forms[0].sel_SancDept.value=="010" || document.forms[0].sel_SancDept.value=="008" || document.forms[0].sel_SancDept.value=="013" || document.forms[0].sel_SancDept.value=="014"|| document.forms[0].sel_SancDept.value=="015"|| document.forms[0].sel_SancDept.value=="016") && document.forms[0].sel_SancBranch.value=="")
	   	{
	   		alert("Select Sanctioning Branch");
	   		document.forms[0].sel_SancBranch.focus();
	   		return;
	   	}
		if (document.forms[0].sel_SancAuth.value == ""||document.forms[0].sel_SancAuth.value == "s") {
			ShowAlert('111', "Sanctioning Authority");
			document.forms[0].sel_SancAuth.focus();
			return;
		}
		if((document.forms[0].sel_SancAuth.value=="15") || (document.forms[0].sel_SancAuth.value=="16")||(document.forms[0].sel_SancAuth.value=="14"))
		{
			if(document.forms[0].txt_sancrefno.value=="")
			{
				ShowAlert('121', "Sanction Reference No"); 	
				document.forms[0].txt_sancrefno.focus();
				return;	
			}
			if(document.forms[0].sanctiondate.value=="")
			{
				ShowAlert('111', "Sanction Date"); 	
				document.forms[0].sanctiondate.focus();
				return;	
			}
		}
		
		if (document.forms[0].txt_district.value == "") {
			ShowAlert('121', "District");
			document.forms[0].txt_district.focus();
			return;
		}
		if (document.forms[0].txt_permzip.value == "") {
			ShowAlert('121', "Pincode");
			document.forms[0].txt_permzip.focus();
			return;
		}
       if (document.forms[0].txtperapp_country.value == "") {
			ShowAlert('121', "Country");
			document.forms[0].txtperapp_country.focus();
			return;
		}
       if (document.forms[0].txt_addresstwo.value == "") {
			ShowAlert('121', "Address");
			document.forms[0].txt_addresstwo.focus();
			return;
		}
      
       	document.forms[0].cmdsave.disabled = true;
		document.forms[0].txt_solcertf.value=document.forms[0].txt_solcertf.value+"/"+document.forms[0].txt_solcertf1.value+"/"+document.forms[0].txt_solcertf2.value;
		document.forms[0].action = appURL + "action/ControllerServlet";
		document.forms[0].hidBeanId.value = "comsolvency";
		document.forms[0].hidBeanGetMethod.value = "updateSolvencyData";
		document.forms[0].hidSourceUrl.value = "/action/com_solvency.jsp";
		document.forms[0].submit();
	}

	
	function showstate() {
		
		var val1 = document.forms[0].hidcity.value;
		var val2 = document.forms[0].hidstate.value;
		if (val1 != "") {
			document.forms[0].hidcity1.value = val1;
		}
		if (val2 != "") {
			document.forms[0].hidstate1.value = val2;
		}
	}
	
	function callSolvencyWorkflow()
	{
		if (sanctionedby!= "")
		{	
			 document.forms[0].action=appURL+"action/solvencyworkflow.jsp?hidBeanId=comsolvency&hidBeanGetMethod=getAction&hidDemoId="+id;
			 document.forms[0].submit(); 
	    }
		else {
			alert("Please Enter the Solvency Details to proceed further ");
	    }
	}

	function funsanctiondept(varfname)
	{
		var varsancdept=document.forms[0].sel_SancDept.value;
		if((varsancdept=="008") || (varsancdept=="010")||(varsancdept=="013") || (varsancdept=="014")||(varsancdept=="015") || (varsancdept=="016"))
		{
			document.all.idsanbranch.style.display="table-cell";
			funsancbranchvalues();
		}
		else{
			document.all.idsanbranch.style.display="none";
			document.forms[0].sel_SancBranch.value="";
		}
		document.all.ifrmsancauthority.src=appURL+"action/iframesancauthority.jsp?hidBeanGetMethod=getSancAuthority&hidBeanId=comproposal&sancdept="+varsancdept+"&sancauth="+varfname;
	}
	function funsancbranchvalues()
	{
		var varsancdept=document.forms[0].sel_SancDept.value;
		document.all.ifrmsancbranch.src=appURL+"action/ifrmsancbranches.jsp?hidBeanGetMethod=getSancBranches&hidBeanId=comproposal&sancdept="+varsancdept+"&sancbranch="+varsanbranch;
	}
	function funsancrefno()
	{
		
		if((document.forms[0].sel_SancAuth.value=="15") || (document.forms[0].sel_SancAuth.value=="16")||(document.forms[0].sel_SancAuth.value=="14"))
		{
			document.all.sanrefno.style.display = "table-cell";
			document.all.sanrefval.style.display = "table-cell";
			document.all.sancdate1.style.display = "table-cell";
			document.all.sancdate2.style.display = "table-cell";	
		}
		else
		{
			document.all.sanrefno.style.display = "none";
			document.all.sanrefval.style.display = "none";
			document.all.sancdate1.style.display = "none";
			document.all.sancdate2.style.display = "none";	
			document.forms[0].txt_sancrefno.value="";
			document.forms[0].sanctiondate.value="";
		}		
	}
	
	function callCalender2()
	{
		if(document.forms[0].cmdsave.disabled==false)
		{
			showCal(appURL,'sanctiondate');
		}
	}	
</script>
</HEAD>
<body onload="onloading();">
<form method="post" class="normal">
<table>
	<tr>
		<td width="50%" align="center" class="sub_tab_active">Solvency</td>

		<td width="50%" align="center" class="sub_tab_inactive"><a
			href="javascript:callSolvencyWorkflow();"
			onMouseOut="window.status='';return true;"
			onMouseOver="window.status='Applicant';return true;"> <b>
		Solvency WorkFlow </b></a></td>

	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable" align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="0"
			class="outertable" align="center">
			<tr>
				<td class="page_flow" colspan="5">Home -> Solvency -> Solvency
				Details</td>
			</tr>
			<tr class="dataheader" align="center">
				<td width="20%">CBS Customer ID</td>
				<td width="20%">Applicant ID</td>
				<td width="20%">Application No.</td>
				<td width="15%">Solvency No.</td>
				<td width="25%">Status :
				<%
					if (strappstatus.equalsIgnoreCase("")) {
				%> New<%
					} else if (strappstatus.equalsIgnoreCase("OP")) {
				%> Open/Pending<%
					} else if (strappstatus.equalsIgnoreCase("PA")) {
				%> Processed/Approved <%
					} else if (strappstatus.equalsIgnoreCase("PR")) {
				%> Processed/Rejected <%
					}  else if(strappstatus.equalsIgnoreCase("CA")) {
				%> Closed/Approved    <%
				    } else if (strappstatus.equalsIgnoreCase("CR")) {
				%> Closed/Rejected  <%} %>
				</td>
			</tr>
			<tr align="center">
				<td><input type="text" class="finaclefieldsbgcolor"
					name="txt_cbsid" size="10" maxlength="10" style="text-align: center"
					value="<%=Helper.correctNull((String) hshValues.get("SOL_CBS_ID"))%>"></td>
					
				<td><input type="text" class="finaclefieldsbgcolor"
					name="old_appid" size="7" maxlength="10" style="text-align: center"
					value="<%=Helper.correctNull((String) hshValues.get("SOL_OLDID"))%>">
				</td>
				<input type="hidden" class="finaclefieldsbgcolor"
					name="hid_appid" size="6" maxlength="10" style="text-align: left"
					value="<%=Helper.correctNull((String) hshValues.get("SOL_APPID"))%>"/>
			
				<td><input type="text" class="finaclefieldsbgcolor"
					name="txt_applno" size="16" maxlength="15" style="text-align: center"
					value="<%=Helper.correctNull((String) hshValues
									.get("SOL_APPL_NO"))%>"></td>
									
				<td><input type="text" name="txt_solno" size="16"
					maxlength="10" style="text-align: center" onkeypress="allowAlphaNumeric()"
					value="<%=Helper.correctNull((String) hshValues.get("sol_solvencyno"))%>">
				</td>
			</tr>
		</table>
		<table width="95%" border="0" cellspacing="0" cellpadding="5"
			class="outertable border1" align="center">
			<tr>
				<td>
				<table width="98%" border="0" cellspacing="0" cellpadding="3"
					class="outertable" align="center">
					<tr>
						<td width="18%">Name of The Applicant<span class="mantatory">*</span></td>
						<td width="29%"><input type="text" name="txt_nameofappl"
							size="35" maxlength="25" class="finaclefieldsbgcolor" tabindex="1"
							onKeyPress="allowAlphabetsForName();notAllowSplChar1(this)"
							value="<%=Helper.correctNull((String) hshValues
							.get("SOL_APPLICANT_NAME"))%>"
							maxlength="25"></td>
						<td width="18%">Purpose<span class="mantatory">*</span></td>
						<td width="33%"><textarea rows="3" cols="55" tabindex="10" style="text-align:left"
							name="txt_purpose" onkeyup="textlimitcorp1(this,128);" onkeydown="textlimitcorp1(this,128);" wrap="VIRTUAL"><%=Helper.correctNull((String) hshValues.get("SOL_PURPOSE"))%></textarea></td>
					</tr>

					<tr>
						<td>Address<span class="mantatory">*</span></td>
						<td><input type="text" name="txt_address" size="35"
							class="finaclefieldsbgcolor" maxlength="50" tabindex="2"
							value="<%=Helper.correctNull((String) hshValues
							.get("SOL_ADDRESS_ONE"))%>"></td>

						<td>Amount [In Rs.]<span class="mantatory">*</span></td>
						<td><lapschoice:CurrencyTag name="txt_amtrs" size="20"
							maxlength="14" tabindex="11" onKeyPress="allowDecimals(this)"
							style="text-align:right" onBlur="roundtxt(this);"
							value='<%=Helper.correctNull((String) hshValues.get("SOL_AMOUNT"))%>' /></td>
					</tr>

					<tr>
						<td></td>
						<td><input type="text" name="txt_addresstwo" size="35"
							class="finaclefieldsbgcolor" maxlength="50" tabindex="3"
							value="<%=Helper.correctNull((String) hshValues
							.get("SOL_ADDRESS_TWO"))%>"></td>

						<td>Commission Earned [In Rs.]<span class="mantatory">*</span></td>
						<td><lapschoice:CurrencyTag name="txt_commissionearn"
							size="20" maxlength="14" tabindex="12"
							onKeyPress="allowDecimals(this)" style="text-align:right"
							onBlur="roundtxt(this);"
							value='<%=Helper.correctNull((String) hshValues
							.get("procfee"))%>' /></td>
					</tr>

					<tr>
						<td>Village/Taluk/Town</td>
						<td><input type="text" name="txt_village" size="35"
							class="finaclefieldsbgcolor" maxlength="20" tabindex="4"
							value="<%=Helper.correctNull((String) hshValues
							.get("SOL_VILLAGE_TALUK_TOWN"))%>"
							onKeyPress="allowAlphabetsForName();"></td>
						<td>Net Worth [In Rs.]<span class="mantatory">*</span></td>
						<td><input type="text" name="txt_networth" size="20"
							class="finaclefieldsbgcolor" onkeypress="notAllowAlphabets();"
							onblur="roundtxt(this);" tabindex="13"
							value="<%=Helper.correctNull((String) hshValues
									.get("SOL_NETWORTH"))%>"
							maxlength="7" style="text-align: right" /></td>
					</tr>

					<tr>
						<td>City<span class="mantatory">*</span></td>
						<td><input type="text" name="txt_city" size="25"
							maxlength="20" tabindex="5" class="finaclefieldsbgcolor"
							value="<%=Helper.correctNull((String) hshValues
							.get("txtperapp_city"))%>"
							onKeyPress="">
							
						    <input type="hidden"
							name="hidperapp_city" size="5"
							value="<%=Helper.correctNull((String) hshValues.get("SOL_CITY"))%>">
							
							</td>
						<td>Existing Account No</td>
						<td><input type="text" name="txt_existacc" size="20"
							onkeypress="allowAlphaNumeric()" tabindex="14"
							value="<%=Helper.correctNull((String) hshValues
							.get("SOL_EXISTING_ACCNO"))%>"
							maxlength="16" style="text-align: right" /></td>
					</tr>

					<tr>
						<td>District<span class="mantatory">*</span></td>
						<td><input type="text" name="txt_district" size="21"
							maxlength="20" tabindex="6" class="finaclefieldsbgcolor"
							value="<%=Helper.correctNull((String) hshValues
							.get("txtperapp_district"))%>"
							onKeyPress="notallowInteger()">
							
							<input type="hidden"
							name="hidperapp_permstate" size="5"
							value="<%=Helper.correctNull((String) hshValues
									.get("SOL_DISTRICT"))%>"></td>
						    
						<td>Solvency Certification No</td>
						<td><input type="text" name="txt_solcertf" size="5" tabindex="15"
							 onkeypress="allowAlphaNumeric()"
							value="<%=strCertNo[0] %>"
							maxlength="15" style="text-align: right">&nbsp;/&nbsp;
							<input type="text" name="txt_solcertf1" size="15" tabindex="16"
							 onkeypress="allowNumber(this)"
							value="<%=strCertNo[1] %>"
							maxlength="15" style="text-align: right">&nbsp;/&nbsp;
							<input type="text" name="txt_solcertf2" size="6" tabindex="17"
							onkeypress="allowAlphaNumeric()"
							value="<%=strCertNo[2] %>"
							maxlength="15" style="text-align: right">&nbsp;<br>Sol
						Id/SIno/Year,Ex:001/01/12-13)</td>
					</tr>

					<tr>
						<td>State</td>
						<td><input type="text" name="txt_state" size="21"
							maxlength="25" tabindex="7" class="finaclefieldsbgcolor"
							value="<%=Helper.correctNull((String) hshValues
							.get("txtperapp_permstate"))%>"
							 onKeyPress="allowAlphabets();" onBlur=""> 
							 <input type="hidden" name="hidperapp_state" size="5"
							value="<%=Helper.correctNull((String) hshValues.get("SOL_STATE"))%>">
						</td>
						<%--  <input type="hidden" name="hidperapp_adminstate" size="5" value="<%=Helper.correctNull((String)hshValues.get("perapp_state_code"))%>"> --%>
						<td>Issue Date </td>
						<td><input type="text" name="txt_issuedt" size="12" tabindex="16"
							value="<%=Helper.correctNull((String) hshValues.get("SOL_DATE"))%>"
							onblur="checkDate(this);" readonly/>&nbsp;</td>
					</tr>

					<tr>
						<td>Pincode<span class="mantatory">*</span></td>
						<td><input type="text" name="txt_permzip" size="12"
							class="finaclefieldsbgcolor" maxlength="6"
							value="<%=Helper.correctNull((String) hshValues
									.get("SOL_PINCODE"))%>"
							tabindex="8" style="text-align: left"
							onKeyPress="allowInteger()" onBlur=""></td>

						<td>Sanctioning Department<span class="mantatory"><b>*</b></span></td>
						<td>
						<table width="40%" border="0" cellspacing="0" cellpadding="3" class="outertable">
						<tr>
						<td>
						<select name="sel_SancDept"  onchange="funsanctiondept('s');">
						<option value="s">--Select--</option>
						<lapschoice:CBSStaticDataNewTag apptype="26" />
						</select>
						</td>
						<td id="idsanbranch">
						<select name="sel_SancBranch" >
						<option value="">--Select--</option>
						</select>
						</td>
						</tr>
						</table>
						</td>
						
					</tr>
					

					<tr>
						<td>Country<span class="mantatory">*</span></td>
						<td><input type="text" name="txtperapp_country"
							class="finaclefieldsbgcolor" size="25" maxlength="15"
							value="<%=Helper.correctNull((String) hshValues
							.get("txtperapp_country"))%>"
							tabindex="9" style="text-align: left"
							onKeyPress="allowAlphabets();"> 
							
							<input type="hidden"
							name="hidperapp_country"
							value="<%=Helper.correctNull((String) hshValues
									.get("SOL_COUNTRY"))%>">
							
						</td>
						
						<td>Sanctioning Authority<span class="mantatory"><b>*</b></span></td>
						<td>
						<select name="sel_SancAuth"   style="width:200px;"  onChange="funsancrefno()">
						<option value="">--Select--</option>
						<lapschoice:CBSStaticDataNewTag apptype="15" />
						</select>
						</td>
<!--						<td>Sanctioned By<span class="mantatory">*</span></td>-->
<!--						<td colspan="3"><select name="sel_sanctby" tabindex="17"-->
<!--							style="width: 200px">-->
<!--							<option value="0" selected="selected">--Select--</option>-->
<!--							<lapschoice:CBSStaticDataNewTag apptype="15" />-->
<!--						</select></td>-->
					</tr>
					<tr>
				<td id="sanrefno">Sanction Reference No.<b><span class="mantatory">*</span></b></td>
				<td id="sanrefval"><input type="text" name="txt_sancrefno" size="37" maxlength="25"	value="<%=Helper.correctNull((String) hshValues.get("Sanc_Ref_No"))%>"></td>
				<td id="sancdate1">Sanction date <b><span class="mantatory">*</span></b></td>	
				<td id="sancdate2">
					<input type="text" name="sanctiondate" maxlength="10" 
					onBlur="checkDate(this);checkmaxdate(this,currentDate);" size="12"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("Sanction_Date"))%>">
				  	&nbsp;<a alt="Select date from calender" href="#"
					onClick="callCalender2()"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
					alt="Select date from calender" align="middle"></a></td>			
			</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete'  btnenable='<%=Helper.correctNull((String) session
							.getAttribute("strBtnenable"))%>'/>
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<iframe height="0" width="0" name="ifrmsancauthority" frameborder="0" style="border:0"></iframe>
<iframe height="0" width="0" name="ifrmsancbranch" frameborder="0" style="border:0"></iframe>
<input type="hidden" name="hididvalue"> <input type="hidden" name="strUserClass"> 
<input type="hidden" name="hidSo">
<input type="hidden" name="cattype" value="<%=strCategoryType%>">
<input type="hidden" name="hidcity" value="<%=Helper.correctNull((String) hshValues
							.get("perapp_city_code"))%>">
<input type="hidden" name="hidstate" value="<%=Helper.correctNull((String) hshValues
							.get("perapp_state_code"))%>">
<input type="hidden" name="hidid" VALUE="<%=Helper.correctNull((String) request
									.getParameter("hidid"))%>">	
<input type="hidden" name="txt_usrid" value="<%=session.getAttribute("strUserId")%>"> 
<input type="hidden" name="txt_loantype" value="<%=Helper.correctNull((String) hshValues
									.get("SOL_LOANTYPE"))%>">

<input type="hidden" name="hidapplno" value="<%=Helper.correctNull((String) hshValues
									.get("SOL_APPL_NO"))%>">
<input type="hidden" name="hidapplname" value="<%=Helper.correctNull((String) hshValues
							.get("SOL_APPLICANT_NAME"))%>">
<input type="hidden" name="hidapplholder" value="<%=Helper.correctNull((String) hshValues
							.get("SOL_APPLNHOLDER"))%>">
<input type="hidden" name="hidapplrecfrom" value="<%=Helper.correctNull((String) hshValues.get("SOL_USRID"))%>">
<input type="hidden" name="hidappstatus" value="<%=Helper.correctNull((String) hshValues.get("SOL_STATUS"))%>">
<input type="hidden" name="hidDemoId" value="<%=Helper.correctNull((String) hshValues.get("strAppid"))%>">
<input type="hidden" name="hidOrgname" value="<%=Helper.correctNull((String) hshValues.get("SOL_NAME"))%>">
<input type="hidden" name="hidAvailFlg" value="<%=Helper.correctNull((String) hshValues
							.get("strDataAvlFlag"))%>">
<input type="hidden" name="btnenable" value="<%=strBtnenable%>">
</form>
</body>
</HTML>
